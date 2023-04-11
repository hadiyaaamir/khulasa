import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedArticle.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Widgets/IconButtons/deleteButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/saveButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/Share/shareButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/speakButton.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class Article extends StatefulWidget {
  // final int i;
  Article({Key? key, required this.art, required this.isSaved})
      : super(key: key);

  var art;
  final bool isSaved;

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
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
                  widget.isSaved
                      ? (widget.art as savedArticle).art.title
                      : (widget.art as article).title,
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
              OptionsLine(
                speakText: widget.isSaved
                    ? "${(widget.art as savedArticle).art.title}.${(widget.art as savedArticle).art.content}"
                    : "${(widget.art as article).title}.${(widget.art as article).content}",
                art: widget.art,
                isSaved: widget.isSaved,
              ),

              //article
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    widget.isSaved
                        ? (widget.art as savedArticle).art.content
                        : (widget.art as article).content,
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
    appUser user = context.watch<UserController>().user;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      child: Column(
        children: [
          // const Divider(color: secondary, thickness: 1.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpeakIconButton(
                speakText: speakText,
                vertPadding: 0,
                iconSize: iconLarge,
                iconColor: isDarkMode ? colors.text2 : colors.secondary,
              ),
              Row(children: [
                isSaved
                    ? DeleteButton(isSummary: false, ss: art as savedArticle)
                    : SaveButton(
                        isSummary: false,
                        ss: savedArticle(
                            art: art,
                            savedOn: DateTime.now(),
                            email: user.email),
                      ),
                const SizedBox(width: 10),
                ShareButton(isRSSFeed: true, content: isSaved ? art.art : art)
              ]),
            ],
          ),
          // const Divider(color: secondary, thickness: 1.2),
        ],
      ),
    );
  }
}
