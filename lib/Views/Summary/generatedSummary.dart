import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Views/Widgets/IconButtons/Share/shareButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/saveButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/speakButton.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class GeneratedSummary extends StatelessWidget {
  const GeneratedSummary({
    super.key,
    required this.summaryText,
    this.title,
    this.alignment = TextAlign.right,
  });

  final String summaryText;
  final String? title;
  final TextAlign alignment;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    appUser user = context.watch<UserController>().currentUser;
    bool isEnglish = context.watch<Language>().isEnglish;

    print('generated: $user');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (summaryText.isNotEmpty) ...[
                Row(
                  children: [
                    Text(
                      isEnglish ? "Summary" : 'اردو',
                      style: TextStyle(
                          color: colors.text,
                          fontSize: largeFont,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5),
                    SpeakIconButton(speakText: summaryText),
                  ],
                ),
                Row(
                  children: [
                    SaveButton(
                        isSummary: true,
                        ss: savedSummary(
                          title: 'summary',
                          savedOn: DateTime.now(),
                          summary: summaryText,
                          email: user.email,
                        )),
                    SizedBox(width: 10),
                    ShareButton(isRSSFeed: false, content: summaryText),
                  ],
                )
              ],
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              children: [
                if (title != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    child: Text(
                      title!,
                      textAlign: alignment,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: headingFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                Align(
                  alignment: alignment == TextAlign.left
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  child: Text(
                    summaryText,
                    textAlign: alignment,
                    style: TextStyle(color: colors.text, fontSize: buttonFont),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
