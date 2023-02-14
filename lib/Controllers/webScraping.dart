import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:khulasa/Models/article.dart';

class WebScraping {
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
}
