import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:provider/provider.dart';

class ThemeSetting extends StatefulWidget {
  const ThemeSetting({super.key});

  @override
  State<ThemeSetting> createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ThemeSetting> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(title: 'Theme Settings'),
    );
  }
}
