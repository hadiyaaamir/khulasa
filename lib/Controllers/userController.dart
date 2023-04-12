import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/savedArticle.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/RSS/article.dart';

import '../Models/user.dart';

CollectionReference userlist = FirebaseFirestore.instance.collection('Users');
CollectionReference summaryList =
    FirebaseFirestore.instance.collection('SavedSummaries');
CollectionReference articleList =
    FirebaseFirestore.instance.collection('SavedArticles');

FirebaseAuth auth = FirebaseAuth.instance;

class UserController extends ChangeNotifier {
  // User get user => _user;
  appUser _currentUser = appUser();
  appUser get currentUser => _currentUser;
  set currentUser(appUser u) {
    _currentUser = u;
    notifyListeners();
  }

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

  getFromDB(String email) async {
    await userlist
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        appUser u = (appUser.fromJson(doc.data() as Map<String, dynamic>));
        currentUser = u;
        notifyListeners();
        print("from db: ${currentUser.toString()}");

        await getUserArticles();
        await getUserSummaries();
      });
    });
    return currentUser;
  }

  setLoggedIn(String e, String password) async {
    try {
      UserCredential uc = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: e, password: password);
      User? us = uc.user;
      appUser u = await getFromDB(e);
      notifyListeners();
      return u;
    } catch (e) {
      print(e);
      return "LoggedIn Failed";
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
    return _currentUser.email == "";
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

  removeArticle(savedArticle art) {
    savdArticles.remove(art);
    notifyListeners();
    art.removeFromDB();
  }

  removeSummary(savedSummary sum) {
    savdSummary.remove(sum);
    notifyListeners();
    sum.removeFromDB();
  }

  getUserArticles() async {
    await articleList
        .where('email', isEqualTo: _currentUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        savedArticle toAdd =
            savedArticle.fromJson(doc.data() as Map<String, dynamic>);
        savdArticles.add(toAdd);
        notifyListeners();
      });
    });
  }

  getUserSummaries() async {
    await summaryList
        .where('email', isEqualTo: _currentUser.email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        savedSummary toAdd =
            savedSummary.fromJson(doc.data() as Map<String, dynamic>);
        savdSummary.add(toAdd);
        notifyListeners();
      });
    });
  }
}
