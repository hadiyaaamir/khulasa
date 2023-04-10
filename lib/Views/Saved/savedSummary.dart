import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/Widgets/iconButtons.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class SavedSummary extends StatelessWidget {
  const SavedSummary({super.key, required this.summary,
  required this.isSummary});

  final savedSummary summary;
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
                    summary.title,
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
                         ShareButton(),
                         DeleteButton(isSummary: isSummary, ss: summary)
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            Text(
              summary.summary,
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
