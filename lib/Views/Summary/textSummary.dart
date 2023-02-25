// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/Views/Summary/generatedSummary.dart';
import 'package:khulasa/Views/Summary/summarySize.dart';
import 'package:khulasa/Views/Widgets/dropdown.dart';
import 'package:khulasa/constants/api.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';

class TextSummary extends StatefulWidget {
  TextSummary({super.key});

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
              // attach == true
              //     ? scanning == true
              //         ? const Center(child: CircularProgressIndicator())
              //         : Text(
              //             extractedText,
              //             textAlign: TextAlign.right,
              //           )
              //     :
              textField(
                label: "Enter text here",
                controller: textController,
                lines: 5,
                textAlign: TextAlign.right,
              ),
              Btn(
                label: "Attach file",
                onPress: () async {
                  setState(() {
                    // attach = false;
                    scanning = true;
                  });
//                   FilePickerResult? result = await FilePicker.platform.pickFiles(
//   type: FileType.custom,
//   allowedExtensions: ['jpg', 'pdf', 'doc'],
// );

                  var i = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (i != null) {
                    imagePicked = i;
                    setState(() {
                      attach = true;
                    });

                    var p = imagePicked.path;
                    extractedText = await FlutterTesseractOcr.extractText(p,
                        language: 'urd+eng');
                    print(extractedText);
                    textController.text = extractedText;
                    setState(() {});
                  }
                  setState(() {
                    scanning = false;
                  });
                },
                background: primary,
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

                    summaryText = summary.summary;
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
