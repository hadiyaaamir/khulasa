import 'package:flutter/material.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/Views/Summary/generatedSummary.dart';
import 'package:khulasa/Views/Summary/summarySize.dart';
import 'package:khulasa/Views/Widgets/dropdown.dart';
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
                onPress: () {
                  final FormState form =
                      _summaryFormKey.currentState as FormState;
                  if (form.validate()) {
                    //generate summary
                    summaryText =
                        "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔ جب ایک گروپ کے 2 میچ بیک وقت کھیلے جانے سے متعلق شیڈول سامنے آیا تو مجھے الجھن ہورہی تھی کہ انہیں دیکھنا کتنا مشکل ہوگا لیکن کل جب یہ مرحلہ اپنے اختتام کو پہنچا تب مجھے اندازہ ہوا کہ اس عالمی کپ کا سب سے دلچسپ حصہ یہی تھا جب ٹیمیں میدان میں دوسرے میچ کے نتیجےکا انتظار کر رہی ہوتی ہیں۔ اس وقت جو دل کی کیفیت ہوتی ہے، سچ پوچھیےتو مجھے یہ کیفیت بہت یاد آئے گی۔ جب گروپ ڈراز منعقد ہوئے اور گھانا اور یوروگوئے ایک ہی گروپ";
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
