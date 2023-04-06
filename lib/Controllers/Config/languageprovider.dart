import 'package:flutter/cupertino.dart';

class Language extends ChangeNotifier {
  bool _isEnglish = true;
  bool get isEnglish => _isEnglish;

  String _drawerLanguage = 'اردو';
  String get drawerLanguage => _drawerLanguage;

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    _drawerLanguage = _isEnglish ? 'اردو' : 'English';
    notifyListeners();
  }

  void toUrdu() {
    _isEnglish = false;
    notifyListeners();
  }

  void toEnglish() {
    _isEnglish = true;
    notifyListeners();
  }
}
