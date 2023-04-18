import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/savedArticle.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/RSS/article.dart';

import '../Models/user.dart';

class UserController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  //logged in user
  appUser _currentUser = appUser();
  appUser get currentUser => _currentUser;
  set currentUser(appUser u) {
    _currentUser = u;
    notifyListeners();
  }

  //list of saved summaries
  List<savedSummary> _savdSummary = [];
  List<savedSummary> get savdSummary => _savdSummary;
  set savdSummary(List<savedSummary> ss) {
    _savdSummary = ss;
    notifyListeners();
  }

  //list of saved articles
  List<savedArticle> _savdArticle = [];
  List<savedArticle> get savdArticles => _savdArticle;
  set savdArticles(List<savedArticle> ss) {
    _savdArticle = ss;
    notifyListeners();
  }

  //Create new user
  Future<void> addToDB(appUser user, String p) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: p,
          )
          .then((value) async => {
                await user.addToDB(),
                print('Firebase user created'),
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

  //get from DB
  getFromDB(String email) async {
    var user = await appUser.getFromDB(email);
    // return user;
    currentUser = user;

    notifyListeners();
  }

  //log in
  setLoggedIn(String e, String password) async {
    try {
      UserCredential uc = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: e, password: password);
      //   User? us = uc.user;
      var user = await appUser.getFromDB(e);
      currentUser = user;
      print('in function: current user is $currentUser');
      notifyListeners();

      getUserArticles();
      getUserSummaries();
      //   notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //sign out
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

  //saved summary functions

  addSummary(savedSummary ss) {
    savdSummary.add(ss);
    notifyListeners();
    ss.addToDB();
  }

  removeSummary(savedSummary sum) {
    savdSummary.remove(sum);
    notifyListeners();
    sum.removeFromDB();
  }

  // saved article functions

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

  getUserArticles() async {
    List<savedArticle> sa =
        await savedArticle.getArticlesFromDB(_currentUser.email);
    savdArticles = sa;
    notifyListeners();
  }

  getUserSummaries() async {
    List<savedSummary> ss =
        await savedSummary.getSummariesFromDB(_currentUser.email);
    savdSummary = ss;
    notifyListeners();
  }
}
