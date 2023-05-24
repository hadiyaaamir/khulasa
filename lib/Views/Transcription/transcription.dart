import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Backend/api.dart';
import 'package:khulasa/Controllers/Backend/files.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/transcriptionController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/transcript.dart';
import 'package:khulasa/Views/Entrance/homePage.dart';
import 'package:khulasa/Views/Transcription/generatedTranscription.dart';
import 'package:khulasa/Views/Widgets/IconButtons/linkInfoButton.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/Controllers/Backend/openAi.dart';

class Transcription extends StatefulWidget {
  const Transcription({super.key});

  @override
  State<Transcription> createState() => _TranscriptionState();
}

class _TranscriptionState extends State<Transcription> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController linkController = TextEditingController();

  // var file;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    Transcript transcript = context.watch<TranscriptionController>().transcript;
    bool isGenerating = context.watch<TranscriptionController>().isGenerating;
    bool fileAttached = context.watch<TranscriptionController>().fileAttatched;
    var file = context.watch<TranscriptionController>().file;
    // bool isGenerating = false;

    return WillPopScope(
      onWillPop: () async =>
          Navigation().navigationReplace(context, const HomePage()),
      child: Directionality(
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: isEnglish ? 'Transcription' : "تحریر"),
          drawer: const Drawer(child: Draw()),
          backgroundColor: colors.background,
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      textField(
                        label: isEnglish ? "Youtube Link" : 'یوٹیوب لنک',
                        controller: linkController,
                        suffixIcon: const LinkInfoButton(isTranscript: true),
                        lines: 1,
                        allowEmpty: true,
                        validate: (value) {
                          return ((value == null || value.isEmpty) &&
                                  !fileAttached)
                              ? isEnglish
                                  ? 'Please enter link or attach a file'
                                  : 'لنک درج کریں یا فائل منسلک کریں'
                              : !RegExp(r"(?:https?:\/\/)?(?:www\.)?youtu\.?be(?:\.com)?\/?.*(?:watch|embed)?(?:.*v=|v\/|\/)([\w\-_]+)\&?",
                                              multiLine: true,
                                              caseSensitive: true)
                                          .hasMatch(linkController.text) &&
                                      !fileAttached
                                  ? isEnglish
                                      ? 'Please enter a valid YouTube link'
                                      : 'درست یوٹیوب لنک درج کریں'
                                  : null;
                        },
                      ),
                      Btn(
                        label: isEnglish ? "Attach mp3" : 'فائل منسلک',
                        background: colors.secondary,
                        height: 30,
                        width: 130,
                        icon: Icons.attach_file,
                        paddingVert: 0,
                        align: Alignment.centerRight,
                        font: largerSmallFont,
                        onPress: () async {
                          context.read<TranscriptionController>().file =
                              await Files().getMp3();
                          context
                              .read<TranscriptionController>()
                              .fileAttatched = true;
                          // setState(() {});
                        },
                      ),
                      if (fileAttached) ...[
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 40, left: 40, top: 10),
                          child: Text((file as File).path,
                              style: TextStyle(
                                  color: colors.text, fontSize: smallFont)),
                        ),
                      ],
                      Btn(
                        label: isEnglish ? "TRANSCRIBE" : 'تحریر کریں',
                        onPress: () async {
                          context.read<TranscriptionController>().isGenerating =
                              true;

                          final FormState form =
                              _formKey.currentState as FormState;
                          if (form.validate()) {
                            if (linkController.text.isNotEmpty) {
                              context.read<TranscriptionController>().file =
                                  await OpenAi()
                                      .youtubeToAudio(linkController.text);

                              context
                                  .read<TranscriptionController>()
                                  .fileAttatched = false;
                            }

                            //   //call transcription function here
                            await context
                                .read<TranscriptionController>()
                                .getTranscription();
                          } else {
                            context
                                .read<TranscriptionController>()
                                .isGenerating = false;
                          }
                        },
                      ),
                      isGenerating
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CircularProgressIndicator(
                                  color: colors.primary))
                          : GeneratedTranscription(transcription: transcript),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
