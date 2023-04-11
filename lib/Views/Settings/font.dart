import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:provider/provider.dart';

class FontSetting extends StatefulWidget {
  const FontSetting({super.key});

  @override
  State<FontSetting> createState() => _FontSettingState();
}

class _FontSettingState extends State<FontSetting> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(title: isEnglish ? 'Font Settings' : ''),
    );
  }
}
