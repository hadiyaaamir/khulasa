import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Backend/dateFormat.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/RSS/article.dart';
import 'package:khulasa/Views/Widgets/IconButtons/speakButton.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

//rss tile
class RssTile extends StatelessWidget {
  RssTile({
    super.key,
    required this.title,
    required this.source,
    required this.date,
    required this.speakText,
    required this.summary,
    required this.art,
    this.isSaved = false,
  });

  final String title;
  final String source;
  final DateTime date;
  final String speakText;
  final String summary;
  var art;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Card(
            color: colors.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              title: Text(
                title,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: colors.text,
                  fontWeight: FontWeight.w900,
                  fontSize: headingFont,
                ),
              ),
              subtitle: Column(
                children: [
                  SourceLine(
                    source: source,
                    date: DateFormatter().formatDate(date, isEnglish),
                    speakText: speakText,
                  ),
                  Text(
                    summary,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: colors.text, fontSize: buttonFont),
                  ),
                ],
              ),
              onTap: () {
                Navigation()
                    .navigation(context, Article(art: art, isSaved: isSaved));
              },
            ),
          ),
        ],
      ),
    );
  }
}

//date and source line thing
class SourceLine extends StatelessWidget {
  const SourceLine({
    super.key,
    required this.source,
    required this.date,
    required this.speakText,
  });

  final String source;
  final String date;
  final String speakText;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          Divider(
              color: isDarkMode ? colors.background : colors.secondary,
              thickness: 1.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpeakIconButton(
                speakText: speakText,
                vertPadding: 0,
                iconColor: isDarkMode ? colors.text : colors.secondary,
              ),
              Directionality(
                textDirection:
                    isEnglish ? TextDirection.ltr : TextDirection.rtl,
                child: Text('$source | $date',
                    style: TextStyle(color: colors.text2)),
              ),
            ],
          ),
          Divider(
              color: isDarkMode ? colors.background : colors.secondary,
              thickness: 1.2),
        ],
      ),
    );
  }
}
