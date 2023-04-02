import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
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

    return Drawer(
      backgroundColor: colors.primary,
      width: screenWidth / 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          // Important: Remove any padding from the ListView.

          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: colors.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      ToggleButton(),
                      ToggleMode(),
                    ],
                  ),

                  //toggle button here
                ),
                const DrawerOption(
                    text: 'RSS Feed',
                    navTo: Categories(),
                    icon: Icons.find_in_page_outlined),
                const DrawerOption(
                    text: 'Summary', navTo: Summary(), icon: Icons.text_fields),
                const DrawerOption(
                  text: 'Saved',
                  navTo: Saved(),
                  icon: Icons.bookmark_border_outlined,
                ),
                const DrawerOption(
                  text: 'Settings',
                  navTo: Settings(),
                  icon: Icons.settings_outlined,
                ),
                DrawerOption(
                    text: 'Logout',
                    navTo: const Login(),
                    textColour: colors.secondary,
                    icon: Icons.logout_outlined),
              ],
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
    required this.navTo,
    required this.icon,
  });

  final Color? textColour;
  final String text;
  final Widget navTo;
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
      onTap: () {
        Navigation().navigationReplace(context, navTo);
      },
    );
  }
}
