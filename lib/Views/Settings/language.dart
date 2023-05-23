import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Settings/settingBtn.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: CustomAppBar(
            title: isEnglish ? 'Language Settings' : 'زبان کی ترتیبات'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              LanguageBtn(
                  text: isEnglish ? 'English' : 'انگریزی',
                  isSelected: isEnglish),
              LanguageBtn(
                  text: isEnglish ? 'Urdu' : 'اردو', isSelected: !isEnglish),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageBtn extends StatelessWidget {
  const LanguageBtn({super.key, required this.text, required this.isSelected});

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
        if (!isSelected) {
          context.read<Language>().toggleLanguage();
        }
      },
    );
  }
}
