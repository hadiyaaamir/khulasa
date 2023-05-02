import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/savedArticle.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/Entrance/login.dart';
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
  addToDB(appUser user, String p) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: user.email,
        password: p,
      )
          .then((value) async {
        // if (value.user != null && !value.user!.emailVerified) {
        //   await value.user!.sendEmailVerification();
        // }
        await user.addToDB();
        print('Firebase user created');
      });
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists for this email.');

        return 'An account already exists for this email';
      }
      return 'Cannot sign you up due to an issue. Please try again.';
      // return e.code;
    } catch (e) {
      print(e);
      return 'An unknown error occurred';
      // return e.toString();
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

      // User? us = uc.user;
      // print('us: $us');

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
  Future<void> setSignOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        print("Logged Out");
        Navigation().navigationReplace(context, const Login());
      });
    } catch (e) {
      print(e);
    }
  }

  bool userNotFound() {
    return _currentUser.email == "";
  }

  //update password
  Future<bool> updatePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    User? u = auth.currentUser;
    bool success = false;
    if (u != null) {
      var cred =
          EmailAuthProvider.credential(email: u.email!, password: oldPassword);
      await u.reauthenticateWithCredential(cred).then((value) async {
        await u.updatePassword(newPassword).then((_) {
          Fluttertoast.showToast(msg: "Password updated!");
          success = true;
        }).catchError((error) {
          success = false;
          print(error);
        });
      }).catchError((err) {
        success = false;
        print(err);
      });
    }
    return success;
  }

  //toggle DarkMode
  setDarkMode(bool isDarkMode) {
    currentUser.darkMode = isDarkMode;
    currentUser.updateInDB(label: 'darkMode', data: isDarkMode);
    notifyListeners();
  }

  //change colour theme
  setColorTheme(String colors) {
    currentUser.colors = colors;
    currentUser.updateInDB(label: 'colorTheme', data: colors);
    notifyListeners();
  }

  //toggle language
  setLanguage(bool isEnglish) {
    currentUser.english = isEnglish;
    currentUser.updateInDB(label: 'english', data: isEnglish);
    notifyListeners();
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
