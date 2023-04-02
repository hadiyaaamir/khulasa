import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class SettingsOption extends StatelessWidget {
  const SettingsOption({super.key, required this.title, required this.navTo});

  final String title;
  final Widget navTo;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return ListTile(
      title: Text(title, style: TextStyle(color: colors.text)),
      trailing: Icon(Icons.keyboard_arrow_right_rounded, color: colors.text2),
      onTap: () {
        Navigation().navigation(context, navTo);
      },
    );
  }
}
