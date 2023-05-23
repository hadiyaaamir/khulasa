import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Backend/api.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/Backend/webScraping.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/Views/Widgets/IconButtons/linkInfoButton.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/Views/Summary/generatedSummary.dart';
import 'package:khulasa/Views/Summary/summarySize.dart';
import 'package:khulasa/Views/Widgets/dropdown.dart';
import 'package:khulasa/constants/api.dart';
import 'package:khulasa/constants/sources.dart';
import 'package:provider/provider.dart';

class LinkSummary extends StatefulWidget {
  LinkSummary({super.key});

  @override
  State<LinkSummary> createState() => _LinkSummaryState();
}

class _LinkSummaryState extends State<LinkSummary> {
  TextEditingController linkController = TextEditingController();

  // String summaryText =
  String summaryText = "";
  String algo = "";
  double ratio = 0;
  String title = "";
  // String website = "";

  final GlobalKey<FormState> _summaryFormKey = GlobalKey<FormState>();
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.watch<Language>().isEnglish;

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: SingleChildScrollView(
        child: Form(
          key: _summaryFormKey,
          child: Center(
            child: Column(
              children: [
                // Dropdown(
                //   label: isEnglish ? "Select Source" : 'اردو',
                //   categories: sources.map((source) => source.source).toList(),
                //   setAlgo: (source) => website = source,
                // ),
                textField(
                  label: isEnglish ? "Link" : 'لنک',
                  controller: linkController,
                  lines: 1,
                  suffixIcon: LinkInfoButton(),
                ),
                Dropdown(
                  label: isEnglish
                      ? "Summarising Algorithm"
                      : 'خلاصہ کنندہ الگورتھم',
                  categories: [summaryChoice1, summaryChoice2],
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
                        var article = await WebScraping().getArticleFromLink(
                          link: linkController.text,
                          source:
                              NewsSource.getSourceFromLink(linkController.text),
                          isLinkSummary: true,
                          isEnglish: isEnglish,
                        );

                        print(
                            NewsSource.getSourceFromLink(linkController.text));

                        if (article.summary == 'error') {
                          isError = true;
                          summaryText = article.content;
                          title = article.title;
                        } else {
                          isError = false;
                          await Api()
                              .generateSummary(
                                algo: getAlgorithm(algo),
                                text: article.content,
                                ratio: ratio,
                              )
                              .then((value) => {
                                    summaryText = value.summary.isNotEmpty
                                        ? value.summary
                                        : article.content
                                  });
                          title = article.title;
                        }
                        // summaryText = article.content;
                        setState(() {});
                      }
                    }),
                GeneratedSummary(
                  summaryText: summaryText,
                  title: title,
                  alignment: isError ? TextAlign.left : TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
