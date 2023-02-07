
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class SavedSummary extends StatelessWidget {
  const SavedSummary({super.key, required this.summary});

  final savedSummary summary;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
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
                    style: const TextStyle(fontSize: headingFont, color: text),
                  ),
                ),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Card(
                      color: background,
                      child: Column(
                        children: const [
                          Icon(
                            Icons.share_rounded,
                            color: primary,
                          ),
                          Text(
                            'Share',
                            style:
                                TextStyle(fontSize: smallFont, color: primary),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Card(
                      color: background,
                      child: Column(
                        children: const [
                          Icon(
                            Icons.delete_forever,
                            color: caution,
                          ),
                          Text(
                            'Delete',
                            style:
                                TextStyle(fontSize: smallFont, color: caution),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            Text(
              summary.summary,
              style: const TextStyle(
                fontSize: buttonFont,
                color: text,
              ),
            )
          ],
        ),
      ),
    );
  }
}
