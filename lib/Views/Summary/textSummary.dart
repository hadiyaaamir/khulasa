import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/Views/Summary/generatedSummary.dart';
import 'package:khulasa/Views/Summary/summarySize.dart';
import 'package:khulasa/Views/Widgets/dropdown.dart';
import 'package:khulasa/constants/api.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class TextSummary extends StatefulWidget {
  TextSummary({super.key});

  @override
  State<TextSummary> createState() => _TextSummaryState();
}

class _TextSummaryState extends State<TextSummary> {
  TextEditingController textController = TextEditingController();

  final GlobalKey<FormState> _summaryFormKey = GlobalKey<FormState>();

  String summaryText = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _summaryFormKey,
        child: Center(
          child: Column(
            children: [
              textField(
                  label: "Enter text here",
                  controller: textController,
                  lines: 5),
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
              Btn(
                label: "GENERATE SUMMARY",
                onPress: () async {
                  final FormState form =
                      _summaryFormKey.currentState as FormState;
                  if (form.validate()) {
                    // generate summary
                    var summary = await Api().generateSummary(
                        algo: summary_type2,
                        text: textController.text,
                        ratio: 0.3);
//                     summaryText = """
// تندرستی بڑی نعمت ہے۔ لیکن آدمی جب تک تندرست رہتا ہے اس نعمت کی قدر نہیں کرتا۔ جب کوئی معمولی بیماری بھی اسے  آ کر گھیر لے تو اس کی قدر معلوم ہو جاتی ہے۔ اگر جسم کے کسی حصے میں تکلیف ہو جاتی ہےتو سارا جسم اثر قبول کرتا ہے۔ تندرستی ہو تو کھانے پینے، چلنے پھرنے اور کام کرنے میں جی لگتا ہے۔ صحت خراب ہو جائے تو کسی چیز میں مزہ نہیں آتا۔جو لوگ اکثر بیمار رہتے ہیں ان کی زندگی خود ان کے اور ان کے دوسرے متعلقین کے لیے وبالِ جان بن جاتی ہے۔
// """;
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
