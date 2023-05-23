import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Backend/openAi.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Views/gpt2.dart';
import 'package:khulasa/constants/apiKeys.dart';
import 'package:path_provider/path_provider.dart';

import 'package:dart_openai/openai.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Transcription extends StatefulWidget {
  const Transcription({super.key});

  @override
  State<Transcription> createState() => _TranscriptionState();
}

class _TranscriptionState extends State<Transcription> {
  var tran = '';
  @override
  Widget build(BuildContext context) {
    OpenAI.apiKey = Chatgptapi;
    TextEditingController textController = TextEditingController();
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          TextField(
            controller: textController,
          ),
          ElevatedButton(
              onPressed: () async {
                var result = await OpenAi()
                    .youtubeToAudio(textController.text)
                    .then((file) async => await OpenAi().transcription(file));

                setState(() {
                  tran = result;
                });

                // var yt = YoutubeExplode();

                // var manifest = await yt.videos.streamsClient
                //     .getManifest(textController.text);
                // var streamInfo = manifest.audioOnly.withHighestBitrate();

                // // Get the actual stream
                // var stream = yt.videos.streamsClient.get(streamInfo);
                // final directory = await getApplicationDocumentsDirectory();
                // var file = File('${directory.path}/audio.mp3');
                // file.createSync();
                // var fileStream = file.openWrite();
                // await stream.pipe(fileStream);
                // await fileStream.flush();
                // await fileStream.close();

                // yt.close();

                // OpenAIAudioModel translation =
                //     await OpenAI.instance.audio.createTranscription(
                //   file: file,
                //   model: "whisper-1",
                //   responseFormat: OpenAIAudioResponseFormat.json,
                // );
                // print(translation);
                // setState(() {
                //   tran = translation.text;
                // });
                // Navigation().navigation(
                //     context,
                //     Chatgpt(
                //       transcription: tran,
                //     ));
              },
              child: const Text("Get audio")),
          Text(tran),
        ],
      )),
    );
  }
}
