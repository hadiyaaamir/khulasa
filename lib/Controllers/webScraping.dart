import 'dart:collection';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/source.dart';

class WebScraping {
  List<String> fixedlink = [
    "https://www.dawnnews.tv/",
    "https://urdu.arynews.tv/"
  ];

  List<Source> sources = [
    Source(
        source: 'Dawn News',
        titleTag: 'story__link',
        contentTag: 'story__content'),
    Source(
        source: 'ARY News',
        titleTag: 'post-title',
        contentTag: 'entry-content clearfix single-post-content'),
  ];

  Future<article> getArticleFromLink({
    required String source,
    required String link,
  }) async {
    // api call
    final response = await http.Client()
        .get(Uri.parse(link), headers: {'User-Agent': 'Mozilla/5.0'});

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        //Scraping the first article title
        int index = sources.indexWhere((element) => element.source == source);
        String title = index != -1
            ? document.getElementsByClassName(sources[index].titleTag)[0].text
            : "";
        String content = index != -1
            ? sources[index].cleanedupArticle(
                document.getElementsByClassName(sources[index].contentTag)[0])
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

  Future<List<String>> getLinksFromLink(String link) async {
    final header = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
    };
    final response = await http.Client().get(Uri.parse(link), headers: header);
    List<String> articleLinks = [];
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        //Scraping the first article title
        var links = document.getElementsByTagName('a');
        links.forEach((element) {
          var l = element.attributes['href'].toString();
          fixedlink.forEach((element) {
            //ary
            if (element == "https://urdu.arynews.tv/" &&
                l != link &&
                l.startsWith(element) &&
                !l.contains("category") &&
                !l.contains("prayer-timings") &&
                !l.contains("latest-news")) {
              articleLinks.add(l);
            }
            //dawn
            if (element == "https://www.dawnnews.tv/" &&
                l != link &&
                l.startsWith(element) &&
                !l.contains("authors") &&
                !l.contains("watch-live") &&
                l.contains("news")) {
              articleLinks.add(l);
            }
          });
        });
        return articleLinks;
      } catch (e) {
        return articleLinks;
      }
    } else {
      return articleLinks;
    }
  }
}
