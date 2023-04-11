import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Settings/settingBtn.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class ModeSetting extends StatefulWidget {
  const ModeSetting({super.key});

  @override
  State<ModeSetting> createState() => _ThemeSettingState();
}

class _ThemeSettingState extends State<ModeSetting> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(title: 'Mode Settings'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            ModeBtn(
              text: 'Light Mode',
              isSelected: !isDarkMode,
              icon: Icons.light_mode,
            ),
            ModeBtn(
              text: 'Dark Mode',
              isSelected: isDarkMode,
              icon: Icons.dark_mode,
            ),
          ],
        ),
      ),
    );
  }
}

class ModeBtn extends StatelessWidget {
  const ModeBtn({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
  });

  final String text;
  final bool isSelected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return GestureDetector(
      child: SettingBtn(
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Icon(icon, color: colors.text),
              const SizedBox(width: 15),
              Text(
                text,
                style: TextStyle(color: colors.text, fontSize: buttonFont),
              ),
            ],
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
