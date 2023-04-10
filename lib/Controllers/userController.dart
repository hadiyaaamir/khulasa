import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/savedArticle.dart';
import 'package:khulasa/Models/savedSummary.dart';

import '../Models/user.dart';

CollectionReference userlist = FirebaseFirestore.instance.collection('Users');
CollectionReference summaryList =
    FirebaseFirestore.instance.collection('SavedSummaries');
CollectionReference articleList =
    FirebaseFirestore.instance.collection('SavedArticles');

FirebaseAuth auth = FirebaseAuth.instance;

class UserController extends ChangeNotifier {
  // User get user => _user;
  appUser user = appUser();
  List<savedSummary> savdSummary = [];
  List<savedArticle> savdArticles = [];

  Future<void> addToDB(appUser user, String p) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: p,
          )
          .then((value) async => {
                print('Firebase user created'),
                await userlist
                    .add(user.toJson())
                    .then((value) => print("User Added"))
                    .catchError((error) => print("Failed to add: $error"))
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFromDB(String email) async {
    await userlist
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        user = (appUser.fromJson(doc.data() as Map<String, dynamic>));
      });
    });
    // notifyListeners();
  }

  Future<void> setLoggedIn(String email, String password) async {
    // await userlist.where('email', isEqualTo: user.email).get().then((value) {
    //   userlist
    //       .doc(value.docs[0].id)
    //       .update({'isLoggedIn': login}).then((value) {
    //     print("Logged in/out!");
    //     user.isLoggedIn = login; // DB? or fine. Check
    //   });
    // });

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  Future<void> setSignOut() async {
    try {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => print("Logged Out"));
    } catch (e) {
      print(e);
    }
  }

  bool userNotFound() {
    return user.email == "";
  }

  addSummary(savedSummary ss) {
    savdSummary.add(ss);
    notifyListeners();
    ss.addToDB();
  }

  addArticle(savedArticle art) {
    savdArticles.add(art);
    notifyListeners();
    art.addToDB();
  }
}
