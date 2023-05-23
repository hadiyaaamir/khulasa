import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedTranscript.dart';
import 'package:khulasa/Views/Widgets/IconButtons/deleteButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/Share/shareButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/speakButton.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class TranscriptView extends StatefulWidget {
  // final int i;
  TranscriptView({Key? key, required this.transcript}) : super(key: key);

  var transcript;

  @override
  State<TranscriptView> createState() => _TranscriptViewState();
}

class _TranscriptViewState extends State<TranscriptView> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(fakeRTL: !isEnglish),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, right: 30, left: 30),
          child: Column(
            children: [
              //title
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  (widget.transcript as savedTranscript).title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Noto Nastaleeq Urdu',
                    color: colors.text,
                    fontWeight: FontWeight.bold,
                    fontSize: headingFont,
                  ),
                ),
              ),

              //options
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SpeakIconButton(
                      speakText: "خلاصہ."
                          "${(widget.transcript as savedTranscript).transcription.summary}."
                          "${isEnglish ? 'Transcription.' : 'تحریر.'}"
                          "${(widget.transcript as savedTranscript).transcription.transcription}",
                      vertPadding: 0,
                      iconSize: iconLarge,
                      iconColor: isDarkMode ? colors.text2 : colors.secondary,
                    ),
                    Row(children: [
                      DeleteButton(
                        isSummary: false,
                        isTranscript: true,
                        ss: widget.transcript as savedTranscript,
                      ),
                      const SizedBox(width: 10),
                      ShareButton(
                          isRSSFeed: false,
                          content: (widget.transcript as savedTranscript)
                              .transcription
                              .transcription)
                    ]),
                  ],
                ),
              ),
              //Transcription View
              Expanded(
                child: SingleChildScrollView(
                  child: Directionality(
                    textDirection:
                        isEnglish ? TextDirection.ltr : TextDirection.rtl,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //summary
                        Text(
                          isEnglish ? 'Summary' : 'خلاصہ',
                          style: TextStyle(
                            color: isDarkMode ? colors.text : colors.secondary,
                            fontSize: buttonFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (widget.transcript as savedTranscript)
                              .transcription
                              .summary,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: colors.text, fontSize: buttonFont),
                        ),

                        const SizedBox(height: 15),

                        //transcription
                        Text(
                          isEnglish ? 'Transcription' : 'تحریر',
                          style: TextStyle(
                            color: isDarkMode ? colors.text : colors.secondary,
                            fontSize: buttonFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (widget.transcript as savedTranscript)
                              .transcription
                              .transcription,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: colors.text, fontSize: buttonFont),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
