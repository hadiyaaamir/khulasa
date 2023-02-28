import 'package:html/dom.dart';

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

  String toString() {
    return "{source: $source, weblink: $webLink, titleTag: $titleTag, contentTag: $contentTag}\n";
  }
}
