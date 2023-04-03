import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/summary.dart';

class appUser {
  appUser({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.darkMode = false,
    this.english = false,
    this.savedSummaries = const [],
    this.isLoggedIn = true,
  });

  String firstName;
  String lastName;
  bool darkMode;
  bool english;

  List<savedSummary> savedSummaries;

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
}
