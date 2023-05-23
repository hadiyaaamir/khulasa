import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
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

    Map<String, ColorTheme> themes = context.watch<DarkMode>().getThemes();

    List<ColorTheme> values = themes.values.toList();
    List<String> keys = themes.keys.toList();
    bool isEnglish = context.watch<Language>().isEnglish;

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: CustomAppBar(
            title: isEnglish ? 'Theme Settings' : 'تھیم کی ترتیبات'),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          itemCount: keys.length,
          itemBuilder: (context, index) =>
              ThemeBtn(text: keys[index], theme: values[index]),
        ),
      ),
    );
  }
}

//option tile
class ThemeBtn extends StatelessWidget {
  const ThemeBtn({
    super.key,
    required this.text,
    required this.theme,
  });

  final String text;
  final ColorTheme theme;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return GestureDetector(
      child: SettingBtn(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${text[0].toUpperCase()}${text.substring(1)} Theme",
              style: TextStyle(
                color: colors.text,
                fontSize: buttonFont,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            //colours row
            Row(
              children: [
                ColorSquare(color: theme.primary),
                ColorSquare(color: theme.secondary),
                ColorSquare(color: theme.text),
                ColorSquare(color: theme.text2),
              ],
            ),
          ],
        ),
        isSelected: theme == colors,
      ),
      onTap: () {
        context.read<DarkMode>().theme = text;
      },
    );
  }
}

class ColorSquare extends StatelessWidget {
  const ColorSquare({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(width: 50, height: 35, color: color);
  }
}
