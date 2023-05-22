import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Saved/savedOptions.dart';
import 'package:khulasa/Views/Settings/settings.dart';
import 'package:khulasa/Views/RSS/categories.dart';
import 'package:khulasa/Views/Summary/summary.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Views/Widgets/NavBar/themeRow.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class Draw extends StatefulWidget {
  const Draw({super.key});

  @override
  State<Draw> createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Drawer(
      backgroundColor: colors.primary,
      // width: screenWidth / 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          // Important: Remove any padding from the ListView.

          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  // DrawerHeader(
                  //   decoration: BoxDecoration(
                  //     color: colors.primary,
                  //   )
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: const [
                  //       ToggleButton(),
                  //       ToggleMode(),
                  //     ],
                  //   ),

                  //   //toggle button here
                  // ),

                  //navigation options
                  DrawerOption(
                    text: isEnglish ? 'RSS Feed' : "آر ایس ایس فیڈ",
                    onPress: () {
                      Navigation()
                          .navigationReplace(context, const Categories());
                    },
                    icon: Icons.find_in_page_outlined,
                  ),
                  DrawerOption(
                    text: isEnglish ? 'Summary' : "خلاصہ",
                    onPress: () {
                      Navigation().navigationReplace(context, const Summary());
                    },
                    icon: Icons.text_fields,
                  ),
                  DrawerOption(
                    text: isEnglish ? 'Saved' : 'محفوظ شدہ اشیاء',
                    onPress: () {
                      Navigation()
                          .navigationReplace(context, const SavedMain());
                    },
                    icon: Icons.bookmark_border_outlined,
                  ),
                  DrawerOption(
                    text: isEnglish ? 'Settings' : 'ترتیبات',
                    onPress: () {
                      Navigation().navigationReplace(context, const Settings());
                    },
                    icon: Icons.settings_outlined,
                  ),

                  //toggle options
                  Divider(color: colors.secondary),
                  DrawerOption(
                    text: isEnglish ? 'اردو' : 'English',
                    onPress: () {
                      context.read<Language>().toggleLanguage();
                    },
                    icon: Icons.language_outlined,
                  ),
                  DrawerOption(
                    text: isDarkMode
                        ? isEnglish
                            ? 'Light Mode'
                            : 'لائٹ موڈ'
                        : isEnglish
                            ? 'Dark Mode'
                            : 'ڈارک موڈ',
                    onPress: () {
                      context.read<DarkMode>().toggleMode();
                    },
                    icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  ),

                  //logout
                  Divider(color: colors.secondary),
                  DrawerOption(
                    text: isEnglish ? 'Logout' : 'لاگ آؤٹ',
                    onPress: () {
                      context.read<UserController>().setSignOut(context);
                      // Navigation().navigationReplace(context, const Login());
                    },
                    icon: Icons.logout_outlined,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: ThemeRow(),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerOption extends StatelessWidget {
  const DrawerOption({
    super.key,
    this.textColour,
    required this.text,
    required this.onPress,
    required this.icon,
  });

  final Color? textColour;
  final String text;
  final Function() onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return ListTile(
      title: Text(text,
          style: TextStyle(
            fontSize: buttonFont,
            color: textColour ?? colors.text,
          )),
      leading: Icon(icon, color: textColour ?? colors.text),
      onTap: onPress,
    );
  }
}
