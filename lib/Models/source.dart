import 'package:html/dom.dart';
import 'package:khulasa/Controllers/dateFormat.dart';

class Source {
  String source;
  String titleTag;
  String contentTag;
  String webLink;

  Source({
    required this.source,
    required this.titleTag,
    required this.contentTag,
    required this.webLink,
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

  getArticle(Document document) {
    if (source == 'ARY News') {
      List paragraphs = document.getElementsByTagName('p');
      String s = "";
      for (var para in paragraphs) {
        s += "${para.text}\n\n";
      }
      return s;
    }

    return document.getElementsByClassName(contentTag)[0].text;
  }

  DateTime getDate(Document document) {
    if (source == "Dawn News") {
      String date =
          document.getElementsByClassName('story__time text-4')[0].text;
      return DateFormat().toDateTime(date);
    } else if (source == "ARY News") {
      String date =
          document.getElementsByTagName('time')[0].attributes['datetime'] ?? "";

      if (date.isNotEmpty) {
        return DateTime.parse(date);
      }
      return DateTime(2000);
    }
    return DateTime(2000);
  }

  @override
  String toString() {
    return "{source: $source, weblink: $webLink, titleTag: $titleTag, contentTag: $contentTag}\n";
  }
}
