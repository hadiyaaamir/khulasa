import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Backend/api.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/transcript.dart';
import 'package:khulasa/Views/Entrance/homePage.dart';
import 'package:khulasa/Views/Transcription/generatedTranscription.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/constants/api.dart';
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

  Transcript transcript = Transcript(transcription: "", summary: "");

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

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
                    children: [
                      textField(
                        label: isEnglish ? "Youtube Link" : 'اردو',
                        controller: linkController,
                        lines: 1,
                      ),
                      Btn(
                        label: isEnglish ? "Attach file" : 'اردو',
                        background: colors.secondary,
                        height: 30,
                        width: 130,
                        icon: Icons.attach_file,
                        paddingVert: 0,
                        align: Alignment.centerRight,
                        font: largerSmallFont,
                        onPress: () {},
                      ),
                      Btn(
                        label: isEnglish ? "TRANSCRIBE" : 'اردو',
                        onPress: () async {
                          final FormState form =
                              _formKey.currentState as FormState;
                          if (form.validate()) {
                            //call transcription function here

                            await OpenAi()
                                .youtubeToAudio(linkController.text)
                                .then(
                                  (file) async =>
                                      await OpenAi().transcription(file).then(
                                    (result) async {
                                      transcript.transcription = result;

                                      //get summary
                                      await Api()
                                          .generateSummary(
                                              algo: summaryType1,
                                              ratio: 0.2,
                                              text: result)
                                          .then(
                                        (value) async {
                                          transcript.summary = value.summary;
                                          if (transcript.summary.isEmpty) {
                                            await Api()
                                                .generateSummary(
                                                    algo: summaryType1,
                                                    ratio: 0.3,
                                                    text: result)
                                                .then((value) =>
                                                    transcript.summary =
                                                        value.summary.isNotEmpty
                                                            ? value.summary
                                                            : result);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                );

                            setState(() {});
                          }
                        },
                      ),
                      GeneratedTranscription(transcription: transcript),
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
