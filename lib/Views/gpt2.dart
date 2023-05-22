import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:khulasa/constants/api.dart';

class Chatgpt extends StatefulWidget {
  const Chatgpt({super.key, required this.transcription});

  final String transcription;

  @override
  State<Chatgpt> createState() => _ChatgptState();
}

class _ChatgptState extends State<Chatgpt> {
  TextEditingController textController = TextEditingController();
  String text = "";
  @override
  Widget build(BuildContext context) {
    OpenAI.apiKey = Chatgptapi;
    return Scaffold(
        appBar: AppBar(title: const Text("ChatGPT")),
        body: Container(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    List messages = [];
                    for (int i = 0;
                        i < widget.transcription.length;
                        i += 2000) {
                      if (i <= widget.transcription.length) {
                        if (i + 2000 <= widget.transcription.length) {
                          messages
                              .add(widget.transcription.substring(i, i + 2000));
                        } else {
                          messages.add(widget.transcription
                              .substring(i, widget.transcription.length));
                        }
                      }
                    }

                  for (var message  in messages) {
                    OpenAIChatCompletionModel chatCompletion =
                        await OpenAI.instance.chat.create(
                      model: "gpt-3.5-turbo",
                      messages: [
                        OpenAIChatCompletionChoiceMessageModel(
                          content:
                              "Write this in proper urdu format with punctuations. Use urdu letters and not roma urdu" +
                               message,
                          role: OpenAIChatMessageRole.user,
                        ),
                      ],
                    );
                    print(chatCompletion.toString());
                    setState(() {
                      text +=
                          chatCompletion.choices[0].message.content.toString() + " ";
                    });
                 
                  }
                   },
                   
                  child: Text("Send")),
              Text("Result: " + text)
            ],
          ),
        ));
  }
}
