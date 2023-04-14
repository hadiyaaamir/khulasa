import 'package:fluttertoast/fluttertoast.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/link.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/source.dart';

class savedArticle {
  DateTime savedOn;
  article art;
  String email;

  savedArticle({
    required this.art,
    required this.savedOn,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = art.title;
    data['summary'] = art.summary;
    data['content'] = art.content;
    data['link'] = art.link!.link;
    data['source'] = art.link!.source.source;
    data['sourceUrdu'] = art.link!.source.sourceUrdu;
    data['webLink'] = art.link!.source.webLink;
    data['dateTag'] = art.link!.source.dateTag;
    data['titleTag'] = art.link!.source.titleTag;
    data['contentTag'] = art.link!.source.contentTag;
    data['rssSummaryRatio'] = art.link!.source.rssSummaryRatio;
    data['date'] = art.date;
    data['category'] = art.category;
    data['savedOn'] = savedOn;
    data['email'] = email;
    return data;
  }

  static savedArticle fromJson(Map<String, dynamic> json) {
    return savedArticle(
        art: article(
          title: json['title'],
          summary: json['summary'],
          content: json['content'],
          date: json['date'].toDate(),
          category: json['category'],
          link: Link(
            link: json['link'],
            source: Source(
              source: json['source'],
              sourceUrdu: json['sourceUrdu'],
              titleTag: json['titleTag'],
              contentTag: json['contentTag'],
              dateTag: json['dateTag'],
              webLink: json['webLink'],
              rssSummaryRatio: json['rssSummaryRatio'],
            ),
          ),
        ),
        savedOn: json['savedOn'].toDate(),
        email: json['email']);
  }

  addToDB() async {
    await articleList.add(toJson()).then((value) {
      print("Article Saved");
      Fluttertoast.showToast(msg: 'Article Saved!');
    }).catchError((error) => print("Failed to add: $error"));
  }

  removeFromDB() async {
    await articleList
        .where('email', isEqualTo: email)
        .where('link', isEqualTo: art.link)
        .where('savedOn', isEqualTo: savedOn)
        .get()
        .then((value) {
      articleList
          .doc(value.docs[0].id)
          .delete()
          .then((value) => print("Article Deleted"))
          .catchError((error) => print("Failed to delete: $error"));
    });
  }
}
