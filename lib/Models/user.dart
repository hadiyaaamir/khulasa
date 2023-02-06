import 'package:khulasa/Models/summary.dart';

class User {
  User({
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.password = "",
    this.savedSummaries = const [],
    this.isLoggedIn = true,
  });

  String firstName;
  String lastName;
  String password;
  List<savedSummary> savedSummaries;
  String email;
  bool isLoggedIn;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['password'] = password;
    data['isLoggedIn'] = isLoggedIn;
    return data;
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      email: json['email'],
      isLoggedIn: json['isLoggedIn'],
    );
  }
}
