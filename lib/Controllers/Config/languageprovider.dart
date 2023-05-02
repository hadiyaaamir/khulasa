import 'package:flutter/cupertino.dart';
import 'package:khulasa/Controllers/userController.dart';

class Language extends ChangeNotifier {
  Language({
    required this.user,
  }) {
    _isEnglish = user.currentUser.english;
  }

  final UserController user;

  bool _isEnglish = true;
  bool get isEnglish => _isEnglish;

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    user.setLanguage(_isEnglish);
    notifyListeners();
  }

  void toUrdu() {
    _isEnglish = false;
    user.setLanguage(_isEnglish);
    notifyListeners();
  }

  void toEnglish() {
    _isEnglish = true;
    user.setLanguage(_isEnglish);
    notifyListeners();
  }
}
