import 'package:flutter/cupertino.dart';
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Controllers/webScraping.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/link.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/Views/RSS/article.dart';
import 'package:khulasa/constants/api.dart';
import 'package:khulasa/constants/sources.dart';

// ignore: camel_case_types
class articleprovider extends ChangeNotifier {
  articleprovider() {
    // getarticleList();
    getArticles();
    notifyListeners();
  }

  List _articleList = [];
  List get articlesList => _articleList;

  bool _isFinished = false;
  bool get isFinished => _isFinished;

  setFinished(bool finish) {
    _isFinished = finish;
    notifyListeners();
  }

  getArticles() async {
    List<Link> links = [];
    _articleList = [];
    setFinished(false);

    for (var element in sources) {
      var l = await WebScraping().getLinksFromLink(element);
      links.addAll(l);
    }

    for (int i = 0; i < links.length; i++) {
      var a = await WebScraping().getArticleFromLink(
          source: links[i].source.source, link: links[i].link);
      // arts.add(a);
      if (a.content.isNotEmpty && a.link != null && a.link!.link.isNotEmpty) {
        await Api()
            .generateSummary(
              algo: summaryType1,
              text: a.content,
              ratio: a.link == null ? 0.1 : a.link!.source.rssSummaryRatio,
            )
            .then((value) => {
                  a.summary =
                      value.summary.isNotEmpty ? value.summary : a.content,
                  _articleList.add(a),
                  notifyListeners(),
                });
        notifyListeners();
      }
    }
    setFinished(true);
  }

  // int get count => _article.length;
  // String gettitle(int i) => _article[i].title;
  // String getcontent(int i) => _article[i].content;
  // String getsummary(int i) => _article[i].summary;
  // String getcategory(int i) => _article[i].category;
}
