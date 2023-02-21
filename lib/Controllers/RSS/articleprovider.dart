import 'package:flutter/cupertino.dart';
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Controllers/webScraping.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/link.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/Views/RSS/article.dart';
import 'package:khulasa/constants/api.dart';

// ignore: camel_case_types
class articleprovider extends ChangeNotifier {
  articleprovider() {
    // getarticleList();
    getArticles();
    notifyListeners();
  }

  List _articleList = [];
  List get articlesList => _articleList;

  final List<article> _article = [
    article(
        title: "سنسنی سے بھرپور گروپ مرحلے کے میچ بہت یاد آئیں گے",
        summary:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        content:
            " راؤنڈ آف 16 ہمارے لیے کیا حیرت انگیز مناظر لائے گا، اس کا انتظار بے صبری سے رہے گاراؤنڈ آف 16 ہمارے لیے کیا حیرت انگیز مناظر لائے گا، اس کا انتظار بے صبری سے رہے گاراؤنڈ آف 16 ہمارے لیے کیا حیرت انگیز مناظر لائے گا، اس کا انتظار بے صبری سے رہے گاراؤنڈ آف 16 ہمارے لیے کیا حیرت انگیز مناظر لائے گا، اس کا انتظار بے صبری سے رہے گاراؤنڈ آف 16 ہمارے لیے کیا حیرت انگیز مناظر لائے گا، اس کا انتظار بے صبری سے رہے گاراؤنڈ آف 16 ہمارے لیے کیا حیرت انگیز مناظر لائے گا، اس کا انتظار بے صبری سے رہے گارہا تھا جو جیت کے بالمی کپ کے یادگار لمحات ہیں۔ تمام ٹیموں کے راؤنڈ آف 16 کے میچ اب واضح ہو چکے ہیں۔ آج سے شروع ہونے والے راؤنڈ آف 16 ہمارے لیے کیا حیرت انگیز مناظر لائے گا، اس کا انتظار بے صبری سے رہے گا۔",
        category: "sports"),
    article(
        title: "سنسنی سے بھرپور گروپ مرحلے کے میچ بہت یاد آئیں گے",
        summary:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        content:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        category: "sports"),
    article(
        title: "سنسنی سے بھرپور گروپ مرحلے کے میچ بہت یاد آئیں گے",
        summary:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        content:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        category: "sports"),
    article(
        title: "سنسنی سے بھرپور گروپ مرحلے کے میچ بہت یاد آئیں گے",
        summary:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        content:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        category: "sports"),
    article(
        title: "سنسنی سے بھرپور گروپ مرحلے کے میچ بہت یاد آئیں گے",
        summary:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        content:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        category: "sports"),
    article(
        title: "سنسنی سے بھرپور گروپ مرحلے کے میچ بہت یاد آئیں گے",
        summary:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        content:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        category: "sports"),
    article(
        title: "سنسنی سے بھرپور گروپ مرحلے کے میچ بہت یاد آئیں گے",
        summary:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        content:
            "ہر روز ایسا لگتا ہے کہ اب اس سے زیادہ ڈراما کیا ہوسکتا ہے لیکن ہر دن فیفا ورلڈ کپ مجھے غلط ثابت کررہا ہے۔",
        category: "sports"),
  ];

  getarticleList() {
    return _article;
    // List<String> links = [];
    // List<Source> sources = WebScraping().sources;
    // for (var element in sources) {
    //   var l = await WebScraping().getLinksFromLink(element.webLink);
    //   links.addAll(l);
    // }
    // print(links);
    // return links;
  } //update later

  getArticles() async {
    List<Link> links = [];
    List<Source> sources = WebScraping().sources;
    List<article> arts = [];

    for (var element in sources) {
      var l = await WebScraping().getLinksFromLink(element.webLink, element);
      links.addAll(l);
    }
    print(links);

    // for (var element in links) {
    //   var a = await WebScraping().getArticleFromLink(
    //       source: element.source.source, link: element.link);
    //   arts.add(a);
    // }
    for (int i = 1; i < 6; i++) {
      var a = await WebScraping().getArticleFromLink(
          source: links[i].source.source, link: links[i].link);
      arts.add(a);
      await Api()
          .generateSummary(
            algo: summaryType1,
            text: a.content,
            ratio: 0.1,
          )
          .then((value) => {a.summary = value.summary});
    }

    print(arts);
    _articleList = arts;
    notifyListeners();
  }

  int get count => _article.length;
  String gettitle(int i) => _article[i].title;
  String getcontent(int i) => _article[i].content;
  String getsummary(int i) => _article[i].summary;
  String getcategory(int i) => _article[i].category;
}
