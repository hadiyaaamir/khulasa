import 'package:flutter/cupertino.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/colors.dart';

class DarkMode extends ChangeNotifier {
  bool isDarkMode = true;

  final ColorTheme _darkMode = ColorTheme(
    background: blue,
    primary: lightBlue,
    secondary: darkBlue,
    text: white,
    text2: grey,
    caution: red,
  );

  final ColorTheme _lightMode = ColorTheme(
    background: veryLightBlue,
    primary: white,
    secondary: lightBlue,
    text: blue,
    text2: grey,
    caution: red,
  );
  // Color caution = red;

  ColorTheme get mode => isDarkMode ? _darkMode : _lightMode;

  void toggleMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  // void toLightMode() {
  //   isDarkMode = false;
  //   notifyListeners();
  // }

  // void toDarkMode() {
  //   isDarkMode = true;
  //   notifyListeners();
  // }
}
