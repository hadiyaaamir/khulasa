import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/tts.dart';
import 'package:khulasa/Views/Widgets/labelIcon.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class GeneratedSummary extends StatelessWidget {
  const GeneratedSummary({super.key, required this.summaryText, this.title});

  final String summaryText;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Summary",
                    style: TextStyle(
                        color: text,
                        fontSize: largeFont,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: const Icon(Icons.volume_up_rounded),
                    onPressed: () {
                      setTtsConfig();
                      flutterTts.setLanguage("ur-PK");
                      flutterTts.speak(summaryText);
                    },
                    color: text,
                    iconSize: largeFont,
                  ),
                ],
              ),
              Row(
                children: [
                  LabelIcon(
                    icon: Icons.save,
                    label: "Save",
                    onPress: () {},
                  ),
                  const SizedBox(width: 10),
                  LabelIcon(
                    icon: Icons.share_rounded,
                    label: "Share",
                    onPress: () {},
                  )
                ],
              )
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
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: text,
                        fontSize: headingFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                Text(
                  summaryText,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: text, fontSize: buttonFont),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
