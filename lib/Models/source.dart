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

  String cleanedupArticle(var article) {
    if (source == 'ARY News') {
      RegExp exp = RegExp(r"<img(.*)>", multiLine: true, caseSensitive: true);
      String replace = article.text.replaceAll(exp, '');
      exp = RegExp(r"Comments", multiLine: true, caseSensitive: true);
      replace = replace.replaceAll(exp, '');
      return replace;
    }
    return article.text;
  }

  DateTime getDate(Document document) {
    if (source == "Dawn News") {
      String date =
          document.getElementsByClassName('story__time text-4')[0].text;
      return DateFormat().toDateTime(date);
    } else if (source == "ARY News") {
      // var element = document
      //     .getElementsByClassName('post-published updated')[0]
      //     .firstChild;
      // var text = element != null ? element.text : "";
      // return text ?? "";

      String date = document
              .getElementsByClassName('post-published updated')[0]
              .attributes['datetime'] ??
          "";
      if (date.isNotEmpty) {
        return DateTime.parse(date);
      }
      return DateTime(2000);
    }
    return DateTime(2000);
  }

  String toString() {
    return "{source: $source, weblink: $webLink, titleTag: $titleTag, contentTag: $contentTag}\n";
  }
}
