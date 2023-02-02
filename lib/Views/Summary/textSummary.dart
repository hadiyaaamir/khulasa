import 'package:flutter/material.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/Views/Summary/summarySize.dart';
import 'package:khulasa/Views/Widgets/dropdown.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class TextSummary extends StatelessWidget {
  TextSummary({super.key});

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            textField(
                label: "Enter text here", controller: textController, lines: 5),
            Btn(
              label: "Attach file",
              onPress: () {},
              background: primary,
              height: 35,
              width: 130,
              icon: Icons.attach_file,
              paddingVert: 0,
              align: Alignment.centerRight,
              font: largerSmallFont,
            ),
            const Dropdown(
              label: "Summarising Algorithm",
              categories: ["Summary 1", "Summary 2"],
              paddingVert: 20,
            ),
            SummarySize(),
            Btn(label: "GENERATE SUMMARY", onPress: () {})
          ],
        ),
      ),
    );
  }
}
