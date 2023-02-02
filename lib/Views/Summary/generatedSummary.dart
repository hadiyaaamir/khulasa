import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Views/Widgets/labelIcon.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class GeneratedSummary extends StatelessWidget {
  GeneratedSummary({super.key, required this.summaryText});

  final String summaryText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Summary",
                style: TextStyle(
                    color: text,
                    fontSize: largeFont,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Row(
                    children: const [
                      LabelIcon(icon: Icons.save, label: "Save"),
                      SizedBox(width: 10),
                      LabelIcon(icon: Icons.share_rounded, label: "Share")
                    ],
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              summaryText,
              textAlign: TextAlign.right,
              style: const TextStyle(color: text, fontSize: buttonFont),
            ),
          ),
        ],
      ),
    );
  }
}
