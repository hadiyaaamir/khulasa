import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:dart_openai/openai.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Transcription extends StatefulWidget {
  const Transcription({super.key});

  @override
  State<Transcription> createState() => _TranscriptionState();
}

class _TranscriptionState extends State<Transcription> {
  @override
  Widget build(BuildContext context) {
    String tran = '';
    OpenAI.apiKey = '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';
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
                var yt = YoutubeExplode();

                var manifest = await yt.videos.streamsClient
                    .getManifest(textController.text);
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

                OpenAIAudioModel translation =
                    await OpenAI.instance.audio.createTranslation(
                  file: file,
                  model: "whisper-1",
                  responseFormat: OpenAIAudioResponseFormat.text,
                );
                setState(() {
                  tran = translation.text;
                });
              },
              child: Text("Get audio")),
          Text("Translation" + tran)
        ],
      )),
    );
  }
}
