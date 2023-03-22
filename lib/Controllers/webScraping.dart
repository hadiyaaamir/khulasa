import 'dart:collection';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:khulasa/Controllers/dateFormat.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/link.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/constants/sources.dart';

class WebScraping {
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
        String title = index != -1 ? sources[index].getTitle(document) : "";
        String content = index != -1 ? sources[index].getArticle(document) : "";
        DateTime date =
            index != -1 ? sources[index].getDate(document) : DateTime(2001);

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

  Future<List<Link>> getLinksFromLink(Source source) async {
    final header = {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          "true", // Required for cookies, authorization headers with HTTPS
    };
    final response =
        await http.Client().get(Uri.parse(source.webLink), headers: header);

    List<Link> articleLinks = [];
    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        //Scraping the first article title
        var links = document.getElementsByTagName('a');
        links.forEach((element) {
          var l = element.attributes['href'].toString();

          if (source.isArticleLink(l)) {
            int index = articleLinks.indexWhere((element) => element.link == l);
            if (index == -1) {
              articleLinks.add(Link(link: l, source: source));
            }
          }
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
