import 'package:flutter/cupertino.dart';

class DarkMode extends ChangeNotifier {
  bool darkMode = true;

  void toLightMode() {
    darkMode = false;
    notifyListeners();
  }

  void toDarkMode() {
    darkMode = true;
    notifyListeners();
  }
}
