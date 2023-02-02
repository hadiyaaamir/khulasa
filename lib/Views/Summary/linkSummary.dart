import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/Views/Summary/summarySize.dart';
import 'package:khulasa/Views/Widgets/dropdown.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class LinkSummary extends StatelessWidget {
  LinkSummary({super.key});

  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const Dropdown(
              label: "Select Source",
              categories: ["Youtube", "Dawn News", "ARY News"],
            ),
            textField(
              label: "Link",
              controller: linkController,
              lines: 1,
            ),
            SummarySize(),
            Btn(label: "GENERATE SUMMARY", onPress: () {})
          ],
        ),
      ),
    );
  }
}
