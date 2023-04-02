import 'package:flutter/cupertino.dart';

class Language extends ChangeNotifier {
  bool _isEnglish = false;
  bool get isEnglish => _isEnglish;

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
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
