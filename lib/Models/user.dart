import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/summary.dart';

CollectionReference userlist = FirebaseFirestore.instance.collection('Users');

class appUser {
  appUser({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.darkMode = false,
    this.english = true,
    this.isLoggedIn = true,
  });

  String firstName;
  String lastName;
  bool darkMode;
  bool english;

  String email;
  bool isLoggedIn;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['isLoggedIn'] = isLoggedIn;
    data['darkMode'] = darkMode;
    data['english'] = english;
    return data;
  }

  static appUser fromJson(Map<String, dynamic> json) {
    return appUser(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      isLoggedIn: json['isLoggedIn'],
      darkMode: json['darkMode'],
      english: json['english'],
    );
  }

  addToDB() async {
    await userlist.add(toJson()).then((value) {
      print("User Created: $email");
    }).catchError((error) => print("Failed to add: $error"));
  }

  static getFromDB(String email) async {
    appUser u = appUser();

    await userlist.where('email', isEqualTo: email).get().then(
      (QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          u = appUser.fromJson(
              querySnapshot.docs.first.data() as Map<String, dynamic>);
        } else {
          u = appUser(email: 'noUser');
        }
      },
    ).catchError((e) => {u = appUser(email: 'issue')});
    print("from db: ${u.toString()}");
    return u;
  }

  String toString() {
    return "email: $email, name: $firstName $lastName";
  }
}
