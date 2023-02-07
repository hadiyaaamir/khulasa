import 'package:flutter/cupertino.dart';

class Language extends ChangeNotifier {
  bool English = true;

  void toUrdu() {
    English = false;
    notifyListeners();
  }

  void toEnglish() {
    English = true;
    notifyListeners();
  }
}
