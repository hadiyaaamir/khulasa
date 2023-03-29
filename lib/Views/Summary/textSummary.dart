import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/Views/Summary/generatedSummary.dart';
import 'package:khulasa/Views/Summary/summarySize.dart';
import 'package:khulasa/Views/Widgets/dropdown.dart';
import 'package:khulasa/constants/api.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class TextSummary extends StatefulWidget {
  const TextSummary({super.key});

  @override
  State<TextSummary> createState() => _TextSummaryState();
}

class _TextSummaryState extends State<TextSummary> {
  TextEditingController textController = TextEditingController();

  final GlobalKey<FormState> _summaryFormKey = GlobalKey<FormState>();

  String summaryText = "";
  String algo = "";
  double ratio = 0;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return SingleChildScrollView(
      child: Form(
        key: _summaryFormKey,
        child: Center(
          child: Column(
            children: [
              textField(
                label: "Enter text here",
                controller: textController,
                lines: 5,
                textAlign: TextAlign.right,
              ),
              Btn(
                label: "Attach file",
                onPress: () {},
                foreground: colors.text,
                background: colors.primary,
                height: 35,
                width: 130,
                icon: Icons.attach_file,
                paddingVert: 0,
                align: Alignment.centerRight,
                font: largerSmallFont,
              ),
              Dropdown(
                label: "Summarising Algorithm",
                categories: [summaryChoice1, summaryChoice2],
                paddingVert: 20,
                setAlgo: (algorithm) => algo = algorithm,
              ),
              SummarySize(
                setSize: (String size) => ratio = getRatio(size),
              ),
              Btn(
                label: "GENERATE SUMMARY",
                onPress: () async {
                  final FormState form =
                      _summaryFormKey.currentState as FormState;
                  if (form.validate()) {
                    // generate summary
                    var summary = await Api().generateSummary(
                      algo: getAlgorithm(algo),
                      text: textController.text,
                      ratio: ratio,
                    );

                    summaryText = summary.summary.isNotEmpty
                        ? summary.summary
                        : textController.text;
                    setState(() {});
                  }
                },
              ),
              GeneratedSummary(summaryText: summaryText)
            ],
          ),
        ),
      ),
    );
  }
}
