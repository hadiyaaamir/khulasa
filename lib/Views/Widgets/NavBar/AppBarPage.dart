import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/languageprovider.dart';
import 'package:khulasa/Models/category.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Entrance/login.dart';
import 'package:khulasa/Views/Settings/settings.dart';
import 'package:khulasa/Views/Widgets/NavBar/Toggle.dart';
import 'package:khulasa/Views/RSS/categories.dart';
import 'package:khulasa/Views/RSS/rssFeed.dart';
import 'package:khulasa/Views/Saved/saved.dart';
import 'package:khulasa/Views/Summary/summary.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Views/Widgets/NavBar/themeRow.dart';
import 'package:khulasa/Views/Widgets/NavBar/toggleMode.dart';
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
    String drawerLanguage = context.watch<Language>().drawerLanguage;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

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
              padding: EdgeInsets.only(top: 120),
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
                    text: 'RSS Feed',
                    onPress: () {
                      Navigation()
                          .navigationReplace(context, const Categories());
                    },
                    icon: Icons.find_in_page_outlined,
                  ),
                  DrawerOption(
                    text: 'Summary',
                    onPress: () {
                      Navigation().navigationReplace(context, const Summary());
                    },
                    icon: Icons.text_fields,
                  ),
                  DrawerOption(
                    text: 'Saved',
                    onPress: () {
                      Navigation().navigationReplace(context, const Saved());
                    },
                    icon: Icons.bookmark_border_outlined,
                  ),
                  DrawerOption(
                    text: 'Settings',
                    onPress: () {
                      Navigation().navigationReplace(context, const Settings());
                    },
                    icon: Icons.settings_outlined,
                  ),

                  //toggle options
                  Divider(color: colors.secondary),
                  DrawerOption(
                    text: drawerLanguage,
                    onPress: () {
                      context.read<Language>().toggleLanguage();
                    },
                    icon: Icons.language_outlined,
                  ),
                  DrawerOption(
                    text: isDarkMode ? 'Light Mode' : 'Dark Mode',
                    onPress: () {
                      context.read<DarkMode>().toggleMode();
                    },
                    icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  ),

                  //logout
                  Divider(color: colors.secondary),
                  DrawerOption(
                    text: 'Logout',
                    onPress: () {
                      Navigation().navigationReplace(context, const Login());
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
