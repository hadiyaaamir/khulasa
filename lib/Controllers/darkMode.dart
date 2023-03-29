import 'package:flutter/cupertino.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/colors.dart';

class DarkMode extends ChangeNotifier {
  bool isDarkMode = true;
  //BLUE
  // final ColorTheme _darkMode = ColorTheme(
  //   background: darkBlue,
  //   primary: lightBlue,
  //   secondary: blue,
  //   text: white,
  //   text2: grey,
  //   caution: red,
  // );

  // final ColorTheme _lightMode = ColorTheme(
  //   background: white,
  //   primary: veryLightBlue,
  //   secondary: thoraBlue,
  //   text: kumDarkBlue,
  //   text2: lightGrey,
  //   caution: red,
  // );
  

  //GREEN
final ColorTheme _darkMode = ColorTheme(
    background: darkBlue,
    primary: lightDarkGreen,
    secondary: darkGreen,
    text: white,
    text2: grey,
    caution: red,
  );

  final ColorTheme _lightMode = ColorTheme(
    background: white,
    primary: darkLightGreen,
    secondary: lightGreen,
    text: veryDarkGreen,
    text2: lightGrey,
    caution: red,
  );
  //ORANGE
  // final ColorTheme _darkMode = ColorTheme(
  //   background: darkBlue,
  //   primary: lightDarkOrange,
  //   secondary: darkOrange,
  //   text: white,
  //   text2: grey,
  //   caution: red,
  // );

  // final ColorTheme _lightMode = ColorTheme(
  //   background: white,
  //   primary: lightOrange,
  //   secondary: darkLightOrange,
  //   text: veryDarkOrange,
  //   text2: lightGrey,
  //   caution: red,
  // );

  //NEUTRAL
  // final ColorTheme _darkMode = ColorTheme(
  //   background: darkBlue,
  //   primary: lightDarkBrown,
  //   secondary: darkBrown,
  //   text: white,
  //   text2: grey,
  //   caution: red,
  // );

  // final ColorTheme _lightMode = ColorTheme(
  //   background: white,
  //   primary: darkLightBrown,
  //   secondary: lightBrown,
  //   text: veryDarkBrown,
  //   text2: lightGrey,
  //   caution: red,
  // );

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
