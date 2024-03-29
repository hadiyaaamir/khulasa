import 'package:html/dom.dart';
import 'package:khulasa/Controllers/Backend/dateFormat.dart';
import 'package:khulasa/constants/sources.dart';

class NewsSource {
  String source;
  String sourceUrdu;
  String titleTag;
  String contentTag;
  String webLink;
  String dateTag;
  double rssSummaryRatio;

  String titleTagType;

  String contentTagType;

  String dateTagType;
  String attributeName;
  int dateIndex;
  bool isDateTime;

  NewsSource({
    required this.source,
    required this.sourceUrdu,
    required this.titleTag,
    required this.contentTag,
    required this.dateTag,
    required this.webLink,
    required this.rssSummaryRatio,
    this.titleTagType = '',
    this.contentTagType = 'class',
    this.dateTagType = 'class',
    this.attributeName = '',
    this.dateIndex = 0,
    this.isDateTime = true,
  });

  // String cleanedupArticle(var article) {
  //   if (source == 'ARY News') {
  //     RegExp exp = RegExp(r"<img(.*)>", multiLine: true, caseSensitive: true);
  //     String replace = article.text.replaceAll(exp, '');
  //     exp = RegExp(r"Comments", multiLine: true, caseSensitive: true);
  //     replace = replace.replaceAll(exp, '');
  //     return replace;
  //   }
  //   return article.text;
  // }

  getTitle(Document document) {
    if (titleTagType == 'tag') {
      return document.getElementsByTagName(titleTag)[0].text;
    }
    return document.getElementsByClassName(titleTag)[0].text;
  }

  getArticle(Document document) {
    if (contentTagType == 'paragraph') {
      List paragraphs = [];
      if (contentTag == 'p') {
        paragraphs = document.getElementsByTagName('p');
      } else {
        paragraphs = document
            .getElementsByClassName(contentTag)[0]
            .getElementsByTagName('p');
      }
      String s = "";
      for (var para in paragraphs) {
        s += "${para.text}\n\n";
      }
      return s;
    }

    return document.getElementsByClassName(contentTag)[0].text;
  }

  DateTime getDate(Document document) {
    if (dateTagType == 'temp-noDate') {
      return DateTime(1990);
    }

    String date = "";

    if (dateTagType == 'class') {
      date = document.getElementsByClassName(dateTag)[dateIndex].text;
    }

    //get by attribute
    else if (dateTagType == 'attribute-tag') {
      date = document
              .getElementsByTagName(dateTag)[dateIndex]
              .attributes[attributeName] ??
          "";
    }

    //get by attribute inside class
    else if (dateTagType == 'attribute-class') {
      date = document
              .getElementsByClassName(dateTag)[dateIndex]
              .attributes[attributeName] ??
          "";
    }

    return DateFormatter().toDateTime(date, isDateTime);
  }

  //verify if link is of article

  bool isArticleLink(String l) {
    //dawn
    if (source == 'Dawn News') {
      RegExp exp = RegExp(r"https://www.dawnnews.tv/news/(.*)",
          multiLine: true, caseSensitive: true);
      return exp.hasMatch(l);
    }

    //ary
    if (source == 'ARY News') {
      return l != webLink &&
          l.startsWith(webLink) &&
          !RegExp(r"https://urdu.arynews.tv/tag(.*)").hasMatch(l) &&
          !l.contains("category") &&
          !l.contains("prayer-timings") &&
          !l.contains("latest-news");
    }

    //jang
    if (source == 'Jang') {
      RegExp exp = RegExp(r"https://jang.com.pk/news/(.*)",
          multiLine: true, caseSensitive: true);
      return exp.hasMatch(l);
    }

    //express
    if (source == 'Express News') {
      RegExp exp = RegExp(r"https://www.express.pk/story/(.*)",
          multiLine: true, caseSensitive: true);
      return exp.hasMatch(l) && !l.contains('comments');
    }

    //nawaiwaqt
    if (source == 'Nawaiwaqt') {
      RegExp exp = RegExp(r"https://www.nawaiwaqt.com.pk/(\d+)",
          multiLine: true, caseSensitive: true);
      return exp.hasMatch(l);
    }

    //jasarat
    if (source == 'Jasarat') {
      RegExp exp = RegExp(r"https://www.jasarat.com/(\d+)/(\d+)/(\d+)/(.*)",
          multiLine: true, caseSensitive: true);
      return exp.hasMatch(l);
      // return true;
    }

    //bbc urdu
    if (source == 'BBC Urdu') {
      RegExp exp = RegExp(r"https://www.bbc.com/urdu/articles/(.*)",
          multiLine: true, caseSensitive: true);
      RegExp exp2 =
          RegExp(r"/urdu/articles/(.*)", multiLine: true, caseSensitive: true);
      return exp.hasMatch(l) || exp2.hasMatch(l);
    }

    //daily pakistan
    if (source == 'Daily Pakistan') {
      RegExp exp = RegExp(
          r"https://dailypakistan.com.pk/(\d+)-(\w+)-(\d+)/(.*)",
          multiLine: true,
          caseSensitive: true);
      return exp.hasMatch(l);
    }

    //Independent
    if (source == 'Independent') {
      RegExp exp = RegExp(r"https://www.independenturdu.com/node/(.*)",
          multiLine: true, caseSensitive: true);
      RegExp exp2 = RegExp(r"/node/(.*)", multiLine: true, caseSensitive: true);
      return exp.hasMatch(l) || exp2.hasMatch(l);
    }

    return false;
  }

  constructProperLink(String l) {
    if (source == 'BBC Urdu' && !l.contains(webLink)) {
      var arr = l.split('urdu');
      return webLink + arr[1];
    }
    if (source == 'Independent' && !l.contains(webLink)) {
      return webLink + l.substring(1);
    }
    return l;
  }

  static String getSourceFromLink(String l) {
    for (var i = 0; i < sources.length; i++) {
      if (sources[i].isArticleLink(l)) return sources[i].source;
    }
    return '';
  }

  static String getNamesList(bool isEnglish) {
    String s = "";
    for (var source in sources) {
      s += "${isEnglish ? source.source : source.sourceUrdu}\n";
    }
    return s;
  }

  @override
  String toString() {
    return "{source: $source, weblink: $webLink, titleTag: $titleTag, contentTag: $contentTag}\n";
  }
}
