// import 'dart:html';
import 'dart:convert';

import 'package:khulasa/Controllers/languageprovider.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Controllers/darkMode.dart';
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
import 'package:syncfusion_flutter_pdf/pdf.dart';

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
                      label: isEnglish ? "Enter text here" : 'اردو',
                      controller: textController,
                      lines: 5,
                      textAlign: TextAlign.right,
                    ),
              Btn(
                label: isEnglish ? "Attach file" : 'اردو',
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

                  // var result = await ImagePicker()
                  //     .pickImage(source: ImageSource.gallery);

                  // if (result != null) {
                  //   imagePicked = result;

                  //   var p = imagePicked.path;
                  //   extractedText =
                  //       await TesseractOcr.extractText(p, language: 'urd'
                  //       );
                  // }

                  String? extractedText = await getText();
                  extractedText == null
                      ? null
                      : textController.text = extractedText;

                  setState(() {
                    scanning = false;
                  });
                },
              ),
              Dropdown(
                label: isEnglish ? "Summarising Algorithm" : 'اردو',
                categories: [summaryChoice1, summaryChoice2],
                paddingVert: 20,
                setAlgo: (algorithm) => algo = algorithm,
              ),
              SummarySize(
                setSize: (String size) => ratio = getRatio(size),
              ),
              Btn(
                label: isEnglish ? "GENERATE SUMMARY" : 'اردو',
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

  Future<String?> getText() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'png', 'docx', 'txt'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      String? p = file.path;
      //image using flutter tesseract ocr
      if ((file.extension == 'png' || file.extension == 'jpg') && p != null) {
        return await FlutterTesseractOcr.extractText(p, language: 'urd+eng');
      } else if (file.extension == 'pdf' && p != null) {
        // pdf reader using syncfusion flutter pdf
        // final ByteData data = await rootBundle.load(p);
        // PdfDocument document = PdfDocument(
        //     inputBytes: data.buffer
        //         .asUint8List(data.offsetInBytes, data.lengthInBytes));

        PDFDoc doc = await PDFDoc.fromPath(p);
        String text = await doc.text;
        // List<int> bytes = text.codeUnits;
        // PdfDocument document = PdfDocument(inputBytes: bytes);

        // return PdfTextExtractor(document).extractText();
        return doc.text;
      } else if ((file.extension == 'docx' ||
              file.extension ==
                  'txt') && //text or docx file read string using rootbundle
          p != null) {
        return await rootBundle.loadString(p);
      }
    }
    return null;
  }
}
