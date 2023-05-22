import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khulasa/Models/transcript.dart';

CollectionReference transcriptList =
    FirebaseFirestore.instance.collection('SavedTranscriptions');

class savedTranscript {
  DateTime savedOn;
  Transcript transcription;
  String email;
  String title;

  savedTranscript({
    required this.transcription,
    required this.savedOn,
    required this.email,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['summary'] = transcription.summary;
    data['transcription'] = transcription.transcription;
    data['savedOn'] = savedOn;
    data['email'] = email;
    return data;
  }

  static savedTranscript fromJson(Map<String, dynamic> json) {
    return savedTranscript(
        transcription: Transcript(
          summary: json['summary'],
          transcription: json['transcription'],
        ),
        title: json['title'],
        savedOn: json['savedOn'].toDate(),
        email: json['email']);
  }

  addToDB() async {
    await transcriptList.add(toJson()).then((value) {
      print("Transcription Saved");
      Fluttertoast.showToast(msg: 'Transcription Saved!');
    }).catchError((error) => print("Failed to add: $error"));
  }

  removeFromDB() async {
    await transcriptList
        .where('title', isEqualTo: title)
        .where('email', isEqualTo: email)
        .where('summary', isEqualTo: transcription.summary)
        .where('savedOn', isEqualTo: savedOn)
        .get()
        .then((value) {
      transcriptList.doc(value.docs[0].id).delete().then((value) {
        print("Transcription Deleted");
        Fluttertoast.showToast(msg: 'Transcription Deleted!');
      }).catchError((error) => print("Failed to delete: $error"));
    });
  }

  static Future<List<savedTranscript>> getTranscriptsFromDB(
      String email) async {
    List<savedTranscript> st = [];
    await transcriptList
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        savedTranscript toAdd =
            savedTranscript.fromJson(doc.data() as Map<String, dynamic>);
        st.add(toAdd);
        // notifyListeners();
      });
    });
    return st;
  }
}
