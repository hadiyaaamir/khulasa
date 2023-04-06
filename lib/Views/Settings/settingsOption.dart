import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class SettingsOption extends StatelessWidget {
  const SettingsOption(
      {super.key,
      required this.title,
      required this.titleUrdu,
      required this.navTo});

  final String title;
  final String titleUrdu;
  final Widget navTo;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return ListTile(
      title: Text(
        isEnglish ? title : titleUrdu,
        style: TextStyle(color: colors.text),
      ),
      trailing: Icon(
        isEnglish
            ? Icons.keyboard_arrow_right_rounded
            : Icons.keyboard_arrow_left_rounded,
        color: colors.text2,
      ),
      onTap: () {
        Navigation().navigation(context, navTo);
      },
    );
  }
}
