// import 'dart:html';
import 'dart:convert';

import 'package:khulasa/Controllers/Backend/files.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khulasa/Controllers/Backend/api.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/Views/Summary/generatedSummary.dart';
import 'package:khulasa/Views/Summary/summarySize.dart';
import 'package:khulasa/Views/Widgets/dropdown.dart';
import 'package:khulasa/constants/api.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';

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
    bool isEnglish = context.watch<Language>().isEnglish;
    bool scanning = false;
    bool attach = false;
    String extractedText = '';
    XFile imagePicked;

    return SingleChildScrollView(
      child: Form(
        key: _summaryFormKey,
        child: Center(
          child: Column(
            children: [
              scanning == true
                  ? textField(
                      label: "Loading",
                      controller: textController,
                      lines: 5,
                      textAlign: TextAlign.right,
                      isLoading: true,
                    )
                  : textField(
                      label:
                          isEnglish ? "Enter text here" : 'یہاں متن درج کریں',
                      controller: textController,
                      lines: 5,
                      textAlign: TextAlign.right,
                    ),
              Btn(
                label: isEnglish ? "Attach file" : 'منسلک کریں',
                background: colors.secondary,
                height: 30,
                width: 130,
                icon: Icons.attach_file,
                paddingVert: 0,
                align: Alignment.centerRight,
                font: largerSmallFont,
                onPress: () async {
                  setState(() {
                    scanning = true;
                  });

                  String? extractedText = await Files().getText();
                  extractedText == null
                      ? null
                      : textController.text = extractedText;

                  setState(() {
                    scanning = false;
                  });
                },
              ),
              Dropdown(
                label: isEnglish
                    ? "Summarising Algorithm"
                    : 'خلاصہ کنندہ الگورتھم',
                categories: [summaryChoice1, summaryChoice2],
                paddingVert: 20,
                setAlgo: (algorithm) => algo = algorithm,
              ),
              SummarySize(
                setSize: (String size) => ratio = getRatio(size),
              ),
              Btn(
                label: isEnglish ? "GENERATE SUMMARY" : 'خلاصہ تشکیل دیں',
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
