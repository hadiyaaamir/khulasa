import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Settings/font.dart';
import 'package:khulasa/Views/Settings/language.dart';
import 'package:khulasa/Views/Settings/mode.dart';
import 'package:khulasa/Views/Settings/personal.dart';
import 'package:khulasa/Views/Settings/settingsOption.dart';
import 'package:khulasa/Views/Settings/theme.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<SettingsOption> options = const [
    SettingsOption(title: 'Personal Details', navTo: Personal()),
    SettingsOption(title: 'Language', navTo: Language()),
    SettingsOption(title: 'Theme', navTo: ThemeSetting()),
    SettingsOption(title: 'Mode', navTo: Mode()),
    SettingsOption(title: 'Font', navTo: Font()),
  ];

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(title: 'Settings'),
      drawer: const Drawer(child: Draw()),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(color: colors.primary);
            },
            itemCount: options.length,
            itemBuilder: (context, index) => options[index]),
      ),
    );
  }
}
