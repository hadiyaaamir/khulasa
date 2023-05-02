import 'package:flutter/cupertino.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/colors.dart';

class DarkMode extends ChangeNotifier {
  DarkMode({
    required this.user,
  }) {
    isDarkMode = user.currentUser.darkMode;
    _theme = user.currentUser.colors;
  }

  final UserController user;

  bool isDarkMode = true;

  final Map<String, ColorTheme> _lightMode = {
    'green': greenLightMode,
    'blue': blueLightMode,
    'orange': orangeLightMode,
    'neutral': neutralLightMode,
  };

  final Map<String, ColorTheme> _darkMode = {
    'green': greenDarkMode,
    'blue': blueDarkMode,
    'orange': orangeDarkMode,
    'neutral': neutralDarkMode,
  };

  String _theme = 'green';
  String get theme => _theme;
  set theme(String t) {
    _theme = t;
    user.setColorTheme(t);
    notifyListeners();
  }

  ColorTheme get mode => isDarkMode
      ? _darkMode[_theme] ?? greenDarkMode
      : _lightMode[_theme] ?? greenLightMode;

  void toggleMode() {
    isDarkMode = !isDarkMode;
    user.setDarkMode(isDarkMode);
    notifyListeners();
  }

  List getThemeList() {
    return _lightMode.keys.toList();
  }

  Map<String, ColorTheme> getThemes() {
    return isDarkMode ? _darkMode : _lightMode;
  }
}
