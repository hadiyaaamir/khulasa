import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedArticle.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/Widgets/IconButtons/Share/shareButton.dart';
import 'package:khulasa/Views/Widgets/IconButtons/deleteButton.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class SavedSummary extends StatelessWidget {
  SavedSummary(
      {super.key, this.ss, required this.isSummary});

  var ss;
  savedArticle? article;
  final bool isSummary;
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(130, 0, 70, 0),
                  child: Text(
                    isSummary?ss.title:ss.art.title,
                    style: TextStyle(
                        fontSize: headingFont,
                        color: colors.text,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Card(
                      color: colors.background,
                      child: Column(
                        children: [
                          ShareButton(
                              content: isSummary?ss.summary:ss.art.summary, isRSSFeed: !isSummary),
                          DeleteButton(isSummary: isSummary, ss:ss),
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            Text(
              isSummary?ss.summary:ss.art.summary,
              style: TextStyle(
                fontSize: buttonFont,
                color: colors.text,
              ),
            )
          ],
        ),
      ),
    );
  }
}
