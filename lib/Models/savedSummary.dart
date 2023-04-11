import 'package:khulasa/Controllers/userController.dart';

class savedSummary {
  String title;
  DateTime savedOn;
  String summary;
  String email;

  savedSummary({
    required this.title,
    required this.savedOn,
    required this.summary,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['summary'] = summary;
    data['savedOn'] = savedOn;
    data['email'] = email;
    return data;
  }

  static savedSummary fromJson(Map<String, dynamic> json) {
    return savedSummary(
      title: json['title'],
      summary: json['summary'],
      savedOn: json['savedOn'].toDate(),
      email: json['email'],
    );
  }

  addToDB() async {
    await summaryList
        .add(toJson())
        .then((value) => print("Summary Saved"))
        .catchError((error) => print("Failed to add: $error"));
  }

  removeFromDB() async {
    await articleList
        .where('email', isEqualTo: email)
        .where('title', isEqualTo: title)
        .where('savedOn', isEqualTo: savedOn)
        .get()
        .then((value) {
      articleList
          .doc(value.docs[0].id)
          .delete()
          .then((value) => print("Summary Deleted"))
          .catchError((error) => print("Failed to delete: $error"));
    });
  }
}
