import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Settings/settingBtn.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/constants/sizes.dart';
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
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(title: 'Theme Settings'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            ThemeBtn(
              text: 'Light Mode',
              isSelected: true,
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeBtn extends StatelessWidget {
  const ThemeBtn({
    super.key,
    required this.text,
    required this.isSelected,
  });

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return GestureDetector(
      child: SettingBtn(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            text,
            style: TextStyle(color: colors.text, fontSize: buttonFont),
          ),
        ),
        isSelected: isSelected,
      ),
      onTap: () {
        context.read<DarkMode>().toggleMode();
      },
    );
  }
}
