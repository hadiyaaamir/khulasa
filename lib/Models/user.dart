import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/constants/colors.dart';

CollectionReference userlist = FirebaseFirestore.instance.collection('Users');

class appUser {
  appUser({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.darkMode = false,
    this.english = true,
    this.isLoggedIn = true,
    this.colors = 'green',
  });

  String firstName;
  String lastName;
  bool darkMode;
  bool english;
  String colors;

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
    data['colorTheme'] = colors;
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
      colors: json['colorTheme'],
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

  //update user
  Future<void> updateInDB({required String label, required var data}) async {
    await userlist.where('email', isEqualTo: email).get().then((value) {
      userlist.doc(value.docs[0].id).update({label: data}).then((value) {
        print("$label set to $data!");
      });
    });
  }

  String toString() {
    return "email: $email, name: $firstName $lastName";
  }
}
