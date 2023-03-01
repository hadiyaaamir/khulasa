import 'dart:collection';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:khulasa/Controllers/dateFormat.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/link.dart';
import 'package:khulasa/Models/source.dart';

class WebScraping {
  // List<String> fixedlink = [
  //   "https://www.dawnnews.tv/",
  //   "https://urdu.arynews.tv/"
  // ];

  List<Source> sources = [
    Source(
        source: 'Dawn News',
        titleTag: 'story__link',
        contentTag: 'story__content',
        webLink: "https://www.dawnnews.tv/"),
    Source(
        source: 'ARY News',
        titleTag: 'post-title',
        contentTag: 'entry-content clearfix single-post-content',
        webLink: "https://urdu.arynews.tv/"),
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
        DateTime date =
            index != -1 ? sources[index].getDate(document) : DateTime.now();

        return article(
          title: title,
          summary: "",
          content: content.trim(),
          link: Link(link: link, source: sources[index]),
          date: date,
        );
      } catch (e) {
        return article(
          title: "",
          summary: "",
          content: 'error!: $e',
          // date: "",
          date: DateTime.now(),
        );
      }
    } else {
      return article(
        title: "",
        summary: "",
        content: 'error ${response.statusCode}',
        // date: "",
        date: DateTime.now(),
      );
    }
  }

  Future<List<Link>> getLinksFromLink(String link, Source source) async {
    final header = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
    };
    final response = await http.Client().get(Uri.parse(link), headers: header);
    List<Link> articleLinks = [];
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        //Scraping the first article title
        var links = document.getElementsByTagName('a');
        links.forEach((element) {
          var l = element.attributes['href'].toString();
          // fixedlink.forEach((element) {
          //ary
          if (link == "https://urdu.arynews.tv/" &&
              l != link &&
              l.startsWith(link) &&
              !RegExp(r"https://urdu.arynews.tv/tag(.*)").hasMatch(l) &&
              !l.contains("category") &&
              !l.contains("prayer-timings") &&
              !l.contains("latest-news")) {
            int index = articleLinks.indexWhere((element) => element.link == l);
            if (index == -1) {
              articleLinks.add(Link(link: l, source: source));
            }
          }
          //dawn
          RegExp exp = RegExp(r"https://www.dawnnews.tv/news/(.*)",
              multiLine: true, caseSensitive: true);
          if (link == "https://www.dawnnews.tv/" && exp.hasMatch(l)
              //     l != link &&
              //     l.startsWith(link) &&
              //     !l.contains("authors") &&
              //     !l.contains("watch-live") &&
              //     l.contains("news")
              ) {
            int index = articleLinks.indexWhere((element) => element.link == l);
            if (index == -1) {
              articleLinks.add(Link(link: l, source: source));
            }
          }
          // });
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
