import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/link.dart';

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
    data['source'] = art.link!.source;
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
          link: Link(link: json['link'], source: json['source']),
        ),
        savedOn: json['savedOn'],
        email: json['email']);
  }
}
