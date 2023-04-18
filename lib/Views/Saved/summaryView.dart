import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Widgets/IconButtons/deleteButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/Share/shareButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/speakButton.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class SummaryView extends StatefulWidget {
  // final int i;
  SummaryView({Key? key, required this.summary}) : super(key: key);

  var summary;

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
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
          padding:
              const EdgeInsets.only(top: 10, bottom: 50, right: 30, left: 30),
          child: Column(
            children: [
              //title
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  (widget.summary as savedSummary).title,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SpeakIconButton(
                    speakText:
                        "${(widget.summary as savedSummary).title}.${(widget.summary as savedSummary).summary}",
                    vertPadding: 0,
                    iconSize: iconLarge,
                    iconColor: isDarkMode ? colors.text2 : colors.secondary,
                  ),
                  Row(children: [
                    DeleteButton(
                        isSummary: true, ss: widget.summary as savedSummary),
                    const SizedBox(width: 10),
                    ShareButton(
                        isRSSFeed: true,
                        content: (widget.summary as savedSummary).summary)
                  ]),
                ],
              ),
              //SummaryView
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    (widget.summary as savedSummary).summary,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: colors.text, fontSize: buttonFont),
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

class OptionsLine extends StatelessWidget {
  OptionsLine({
    super.key,
    required this.speakText,
    required this.art,
    required this.isSaved,
  });

  final String speakText;
  var art;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    appUser user = context.watch<UserController>().currentUser;

    print('SummaryView: $user');

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      child: Column(
        children: [
          // const Divider(color: secondary, thickness: 1.2),

          // const Divider(color: secondary, thickness: 1.2),
        ],
      ),
    );
  }
}
