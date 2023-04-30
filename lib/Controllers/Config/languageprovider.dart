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

  String _drawerLanguage = 'اردو';
  String get drawerLanguage => _drawerLanguage;

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    _drawerLanguage = _isEnglish ? 'اردو' : 'English';
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
