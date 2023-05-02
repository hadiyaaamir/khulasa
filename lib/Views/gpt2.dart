import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Chatgpt extends StatefulWidget {
  const Chatgpt({super.key});

  @override
  State<Chatgpt> createState() => _ChatgptState();
}

class _ChatgptState extends State<Chatgpt> {
  TextEditingController textController = TextEditingController();
  String text = "";
  @override
  Widget build(BuildContext context) {
    OpenAI.apiKey = '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';
    return Scaffold(
        appBar: AppBar(title: const Text("ChatGPT")),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: textController,
              ),
              ElevatedButton(
                  onPressed: () async {
                    OpenAIChatCompletionModel chatCompletion =
                        await OpenAI.instance.chat.create(
                      model: "gpt-3.5-turbo",
                      messages: [
                        OpenAIChatCompletionChoiceMessageModel(
                          content: "Write this in proper urdu format" +
                              textController.text,
                          role: OpenAIChatMessageRole.user,
                        ),
                      ],
                    );
                    print(chatCompletion.toString());
                    setState(() {
                      text = chatCompletion.choices[0].message.content.toString();
                    });
                  },
                  child: Text("Send")),

                  Text("Result: "+ text)
            ],
          ),
        ));
  }
}
