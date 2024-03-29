import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

CollectionReference summaryList =
    FirebaseFirestore.instance.collection('SavedSummaries');

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
    await summaryList.add(toJson()).then((value) {
      print("Summary Saved");
      Fluttertoast.showToast(msg: 'Summary Saved!');
    }).catchError((error) => print("Failed to add: $error"));
  }

  removeFromDB() async {
    await summaryList
        .where('email', isEqualTo: email)
        .where('title', isEqualTo: title)
        .where('savedOn', isEqualTo: savedOn)
        .get()
        .then((value) {
      summaryList.doc(value.docs[0].id).delete().then((value) {
        print("Summary Deleted");
        Fluttertoast.showToast(msg: 'Summary Deleted');
      }).catchError((error) => print("Failed to delete: $error"));
    });
  }

  static Future<List<savedSummary>> getSummariesFromDB(String email) async {
    List<savedSummary> ss = [];
    await summaryList
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        savedSummary toAdd =
            savedSummary.fromJson(doc.data() as Map<String, dynamic>);
        ss.add(toAdd);
        // notifyListeners();
      });
    });
    return ss;
  }
}
