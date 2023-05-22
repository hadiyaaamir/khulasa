import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/savedTranscript.dart';
import 'package:khulasa/Models/transcript.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Views/Widgets/IconButtons/Share/shareButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/saveButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/speakButton.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class GeneratedTranscription extends StatelessWidget {
  const GeneratedTranscription({
    super.key,
    required this.transcription,
    this.alignment = TextAlign.right,
  });

  final Transcript transcription;
  final TextAlign alignment;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    appUser user = context.watch<UserController>().currentUser;
    bool isEnglish = context.watch<Language>().isEnglish;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    print('generated: $user');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Column(
        children: [
          if (transcription.summary.isNotEmpty &&
              transcription.transcription.isNotEmpty) ...[
            //transcription title + share/save row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      isEnglish ? "Transcript" : 'تحریر',
                      style: TextStyle(
                          color: colors.text,
                          fontSize: largeFont,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    SpeakIconButton(
                      speakText: "خلاصہ."
                          "${transcription.summary}."
                          "${isEnglish ? 'Transcription.' : 'تحریر.'}"
                          "${transcription.transcription}",
                    ),
                  ],
                ),
                Row(
                  children: [
                    SaveButton(
                        isSummary: false,
                        isTranscript: true,
                        ss: savedTranscript(
                          title: '',
                          savedOn: DateTime.now(),
                          transcription: transcription,
                          email: user.email,
                        )),
                    SizedBox(width: 10),
                    ShareButton(
                        isRSSFeed: false, content: transcription.transcription),
                  ],
                )
              ],
            ),
            //space
            const SizedBox(height: 20),

            //content
            Align(
              alignment: Alignment.bottomRight,
              child: Align(
                alignment: alignment == TextAlign.left
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
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
                      transcription.summary,
                      textAlign: alignment,
                      style:
                          TextStyle(color: colors.text, fontSize: buttonFont),
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
                      transcription.transcription,
                      textAlign: alignment,
                      style:
                          TextStyle(color: colors.text, fontSize: buttonFont),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
