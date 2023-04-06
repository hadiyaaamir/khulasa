import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/savedSummary.dart';

class savedProvider extends ChangeNotifier {
  List<savedSummary> savdSummary = [];
  List<savedSummary> savdArticles = [];
  setList(bool isSummary, List<savedSummary> list) {
    if (isSummary) {
      savdSummary = list;
    } else {
      savdArticles = list;
    }
    notifyListeners();
  }

  Future<void> getSavedDB(bool isSummary) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: user.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (isSummary) {
          List<savedSummary> s =
              (doc.data() as Map<String, dynamic>)['savedSummary'];
          user.savedSummaries = s;
          setList(true, s);
        } else {
          List<savedSummary> a =
              (doc.data() as Map<String, dynamic>)['savedArticles'];
          user.savedArticles = a;
          setList(false, a);
        }
      });
    });
  }

  Future<void> addSummaryDB(bool isSummary, savedSummary ss) async {
    CollectionReference userlist =
        FirebaseFirestore.instance.collection('Users');
    String db = "";
    List<savedSummary> list = [];

    await userlist.where('email', isEqualTo: user.email).get().then((value) {
      if (isSummary) {

        db = 'savedSummaries';
        savdSummary.add(ss);
        list= savdArticles;
        notifyListeners();
      } else {
        db = 'savedArticles';
        savdArticles.add(ss);
        list= savdArticles;
        notifyListeners();
        
      }
      userlist.doc(value.docs[0].id).update({db: list }).then((value) {
        print("New summry/article add: ${ss}!");
      });
    });
  }
  Future<void> removeSummaryDB(bool isSummary, savedSummary ss) async {
    CollectionReference userlist =
        FirebaseFirestore.instance.collection('Users');
    String db = "";
    List<savedSummary> list = [];

    await userlist.where('email', isEqualTo: user.email).get().then((value) {
      if (isSummary) {

        db = 'savedSummaries';
        savdSummary.remove(ss);
        list= savdArticles;
        notifyListeners();
      } else {
        db = 'savedArticles';
        savdArticles.remove(ss);
        list= savdArticles;
        notifyListeners();
        
      }
      userlist.doc(value.docs[0].id).update({db: list }).then((value) {
        print("Summry/article remove: ${ss}!");
      });
    });
  }
}