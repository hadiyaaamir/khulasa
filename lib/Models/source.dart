import 'package:html/dom.dart';

class Source {
  String source;
  String titleTag;
  String contentTag;

  Source({
    required this.source,
    required this.titleTag,
    required this.contentTag,
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
}
