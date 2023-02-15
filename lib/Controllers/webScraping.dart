import 'dart:collection';

import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:khulasa/Models/article.dart';

class WebScraping {
  List<String> fixedlink = [
    "https://www.dawnnews.tv/",
    "https://urdu.arynews.tv/"
  ];
  // getArticleFromLink(String linkWebpage, String articleLink) async {
  //   var webScraper = WebScraper(linkWebpage);
  //   print("İm waiting");

  //   if (await webScraper.loadWebPage(articleLink)) {
  //     print("İ got in");
  //     List<Map<String, dynamic>> results =
  //         webScraper.getElement('div.center', ['title']);
  //     // return results[0];
  //     print(results);
  //   }
  // }

  Future<article> getArticleFromLink(link) async {
    // final header = {
    //   "Access-Control-Allow-Origin": "*", // Required for CORS support to work
    //   "Access-Control-Allow-Credentials":
    //       "true", // Required for cookies, authorization headers with HTTPS
    // };
    final response = await http.Client().get(Uri.parse(link));

    if (response.statusCode == 200) {
      var document = parser.parse(response.body);
      try {
        //Scraping the first article title
        var title = document.getElementsByClassName('story__link')[0].text;
        var content = document.getElementsByClassName('story__content')[0].text;
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
