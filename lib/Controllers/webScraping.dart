import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:khulasa/Models/article.dart';

class WebScraping {
  //get article and title given link

  Future<article> getArticleFromLink({
    required String source,
    required String link,
  }) async {
    //constants: tags for each source
    Map<String, String> sourceTags_title = {
      'Dawn News': 'story__link',
      'ARY News': 'post-title',
    };

    Map<String, String> sourceTags_article = {
      'Dawn News': 'story__content',
      'ARY News': 'entry-content clearfix single-post-content',
    };

    // api call
    final response = await http.Client()
        .get(Uri.parse(link), headers: {'User-Agent': 'Mozilla/5.0'});

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        //Scraping the first article title
        var title = sourceTags_title.containsKey(source)
            ? document.getElementsByClassName(sourceTags_title[source]!)[0].text
            : "";
        var content = sourceTags_article.containsKey(source)
            ? document
                .getElementsByClassName(sourceTags_article[source]!)[0]
                .text
            : "";

        return article(title: title, summary: "", content: content.trim());
      } catch (e) {
        return article(title: "", summary: "", content: 'error!: $e');
      }
    } else {
      return article(
          title: "", summary: "", content: 'error ${response.statusCode}');
    }
  }
}
