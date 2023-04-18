import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/link.dart';
import 'package:khulasa/constants/sources.dart';

CollectionReference articleList =
    FirebaseFirestore.instance.collection('SavedArticles');

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
    data['date'] = art.date;
    data['category'] = art.category;
    data['savedOn'] = savedOn;
    data['email'] = email;
    return data;
  }

  static savedArticle fromJson(Map<String, dynamic> json) {
    int sourceIndex =
        sources.indexWhere((element) => element.source == json['source']);

    return savedArticle(
        art: article(
          title: json['title'],
          summary: json['summary'],
          content: json['content'],
          date: json['date'].toDate(),
          category: json['category'],
          link: Link(
            link: json['link'],
            source: sourceIndex != -1 ? sources[sourceIndex] : sources[0],
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
        .where('title', isEqualTo: art.title)
        .where('email', isEqualTo: email)
        .where('summary', isEqualTo: art.summary)
        .where('link', isEqualTo: art.link!.link)
        .where('source', isEqualTo: art.link!.source.source)
        .where('date', isEqualTo: art.date)
        .where('category', isEqualTo: art.category)
        .where('savedOn', isEqualTo: savedOn)
        .get()
        .then((value) {
      articleList.doc(value.docs[0].id).delete().then((value) {
        print("Article Deleted");
        Fluttertoast.showToast(msg: 'Article Deleted!');
      }).catchError((error) => print("Failed to delete: $error"));
    });
  }

  static Future<List<savedArticle>> getArticlesFromDB(String email) async {
    List<savedArticle> sa = [];
    await articleList
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        savedArticle toAdd =
            savedArticle.fromJson(doc.data() as Map<String, dynamic>);
        sa.add(toAdd);
        // notifyListeners();
      });
    });
    return sa;
  }
}
