import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Controllers/webScraping.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Entrance/textfield.dart';
import 'package:khulasa/Views/Summary/generatedSummary.dart';
import 'package:khulasa/Views/Summary/summarySize.dart';
import 'package:khulasa/Views/Widgets/dropdown.dart';
import 'package:khulasa/constants/api.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class LinkSummary extends StatefulWidget {
  LinkSummary({super.key});

  @override
  State<LinkSummary> createState() => _LinkSummaryState();
}

class _LinkSummaryState extends State<LinkSummary> {
  TextEditingController linkController = TextEditingController();

  // String summaryText =
  //     "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔ جب ایک گروپ کے 2 میچ بیک وقت کھیلے جانے سے متعلق شیڈول سامنے آیا تو مجھے الجھن ہورہی تھی کہ انہیں دیکھنا کتنا مشکل ہوگا لیکن کل جب یہ مرحلہ اپنے اختتام کو پہنچا تب مجھے اندازہ ہوا کہ اس عالمی کپ کا سب سے دلچسپ حصہ یہی تھا جب ٹیمیں میدان میں دوسرے میچ کے نتیجےکا انتظار کر رہی ہوتی ہیں۔ اس وقت جو دل کی کیفیت ہوتی ہے، سچ پوچھیےتو مجھے یہ کیفیت بہت یاد آئے گی۔ جب گروپ ڈراز منعقد ہوئے اور گھانا اور یوروگوئے ایک ہی گروپ";
  String summaryText = "";
  String algo = "";
  double ratio = 0;
  String title = "";
  List<String> categoryList = ["Youtube", "Dawn News", "ARY News"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Dropdown(
              label: "Select Source",
              categories: categoryList,
              setAlgo: (algorithm) => algo = algorithm,
            ),
            textField(
              label: "Link",
              controller: linkController,
              lines: 1,
            ),
            Dropdown(
              label: "Summarising Algorithm",
              categories: [summaryChoice1, summaryChoice2],
              setAlgo: (algorithm) => algo = algorithm,
            ),
            SummarySize(
              setSize: (String size) => ratio = getRatio(size),
            ),
            Btn(
                label: "GENERATE SUMMARY",
                onPress: () async {
                  var article = await WebScraping()
                      .getArticleFromLink(linkController.text);
                  print(ratio);
                  print(algo);
                  var summary = await Api().generateSummary(
                    algo: getAlgorithm(algo),
                    text: article.content,
                    ratio: ratio,
                  );
                  summaryText = summary.summary;
                  title = article.title;
                  // summaryText = article;
                  setState(() {});
                }),
            GeneratedSummary(summaryText: summaryText, title: title),
          ],
        ),
      ),
    );
  }
}
