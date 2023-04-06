import 'package:flutter/cupertino.dart';
import 'package:khulasa/Controllers/Backend/api.dart';
import 'package:khulasa/Controllers/Backend/webScraping.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/link.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/Views/RSS/article.dart';
import 'package:khulasa/constants/api.dart';
import 'package:khulasa/constants/sources.dart';

// ignore: camel_case_types
class articleprovider extends ChangeNotifier {
  // articleprovider() {
  //   // getarticleList();
  //   getArticles();
  //   notifyListeners();
  // }

  List _articleList = [];
  List get articlesList => _articleList;

  bool _isFinished = false;
  bool get isFinished => _isFinished;

  setFinished(bool finish) {
    _isFinished = finish;
    notifyListeners();
  }

  addByDate(article a) {
    articlesList.add(a);

    for (int i = articlesList.length - 1; i > 0; i--) {
      if (a.isNewerThan(articlesList[i - 1])) {
        //swap
        article temp = articlesList[i - 1];
        articlesList[i - 1] = a;
        articlesList[i] = temp;
      } else {
        break;
      }
    }
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
        await Api().getCategory(a.title).then((value) => a.category = value);
        await Api()
            .generateSummary(
              algo: summaryType1,
              text: a.content,
              ratio: a.link == null ? 0.1 : a.link!.source.rssSummaryRatio,
            )
            .then((value) async => {
                  a.summary = value.summary,
                  if (a.summary.isEmpty)
                    {
                      await Api()
                          .generateSummary(
                            algo: summaryType1,
                            text: a.content,
                            ratio: a.link == null
                                ? 0.1
                                : (a.link!.source.rssSummaryRatio + 0.1),
                          )
                          .then((value) => a.summary = value.summary.isNotEmpty
                              ? value.summary
                              : a.content)
                    },
                  addByDate(a),
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
