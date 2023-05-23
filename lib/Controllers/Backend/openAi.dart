import 'dart:io';

import 'package:dart_openai/openai.dart';
import 'package:khulasa/Controllers/Backend/files.dart';
import 'package:khulasa/constants/apiKeys.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class OpenAi {
  // Future<String> youtubeToText(String link) async {
  //   String tran = '';
  //   await youtubeToAudio(link).then(
  //     (file) async => await transcription(file).then(
  //       (ttext) async =>
  //           await formatTranscription(ttext).then((value) => tran = value),
  //     ),
  //   );
  //   return tran;
  // }

  Future<File> youtubeToAudio(String link) async {
    var yt = YoutubeExplode();

    var manifest = await yt.videos.streamsClient.getManifest(link);
    var streamInfo = manifest.audioOnly.withHighestBitrate();

    // Get the actual stream
    var stream = yt.videos.streamsClient.get(streamInfo);
    final directory = await getApplicationDocumentsDirectory();
    var file = File('${directory.path}/audio.mp3');
    file.createSync();
    var fileStream = file.openWrite();
    await stream.pipe(fileStream);
    await fileStream.flush();
    await fileStream.close();

    yt.close();

    return file;
  }

  Future<String> transcription(File file) async {
    OpenAI.apiKey = Chatgptapi;

    // OpenAIAudioModel
    String transcription = await OpenAI.instance.audio
        .createTranscription(
      file: file,
      model: "whisper-1",
      responseFormat: OpenAIAudioResponseFormat.json,
    )
        .then((value) async {
      print(value);
      try {
        return await formatTranscription(value.text);
      } catch (e) {
        return value.text;
      }
    });
    // var tran = await formatTranscription(transcription.text)
    return transcription;
  }

  List fragmentString(String t) {
    List messages = [];
    for (int i = 0; i < t.length; i += 2000) {
      if (i <= t.length) {
        if (i + 2000 <= t.length) {
          messages.add(t.substring(i, i + 2000));
        } else {
          messages.add(t.substring(i, t.length));
        }
      }
    }
    return messages;
  }

  Future<String> formatTranscription(String t) async {
    String text = "";

    List messages = fragmentString(t);
    OpenAI.apiKey = Chatgptapi;
    for (var message in messages) {
      OpenAIChatCompletionModel chatCompletion =
          await OpenAI.instance.chat.create(
        model: "gpt-3.5-turbo",
        messages: [
          OpenAIChatCompletionChoiceMessageModel(
            content:
                "Write this in proper urdu format with punctuations. Use urdu letters and not roman urdu $message",
            role: OpenAIChatMessageRole.user,
          ),
        ],
      );
      print(message);
      // print(chatCompletion.toString());

      text += "${chatCompletion.choices[0].message.content} ";
    }
    return text;
  }
}
