import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Entrance/homePage.dart';
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
    SettingsOption(
        title: 'Personal Details', titleUrdu: 'اردو', navTo: Personal()),
    SettingsOption(
        title: 'Language', titleUrdu: 'اردو', navTo: LanguageSetting()),
    SettingsOption(title: 'Theme', titleUrdu: 'اردو', navTo: ThemeSetting()),
    SettingsOption(title: 'Mode', titleUrdu: 'اردو', navTo: ModeSetting()),
    // SettingsOption(title: 'Font', titleUrdu: 'اردو', navTo: FontSetting()),
  ];

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return WillPopScope(
      onWillPop: () async =>
          Navigation().navigationReplace(context, const HomePage()),
      child: Directionality(
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          backgroundColor: colors.background,
          appBar: CustomAppBar(title: isEnglish ? 'Settings' : ''),
          drawer: const Drawer(child: Draw()),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(color: colors.primary);
                },
                itemCount: options.length,
                itemBuilder: (context, index) => options[index]),
          ),
        ),
      ),
    );
  }
}
