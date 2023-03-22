import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/category.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Entrance/login.dart';
import 'package:khulasa/Views/NavBar/Toggle.dart';
import 'package:khulasa/Views/RSS/categories.dart';
import 'package:khulasa/Views/RSS/rssFeed.dart';
import 'package:khulasa/Views/Saved/saved.dart';
import 'package:khulasa/Views/Summary/summary.dart';
import 'package:khulasa/Controllers/navigation.dart';
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
      width: screenWidth / 3 + 11,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: const EdgeInsets.all(
          10,
        ),

        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: colors.primary,
            ),
            child: const ToggleButton(),

            //toggle button here
          ),
          ListTile(
            title: Text('RSS feed',
                style: TextStyle(
                  fontSize: buttonFont,
                  color: colors.text,
                )),
            onTap: () {
              Navigation().navigationReplace(context, const RssFeed());
            },
          ),
          ListTile(
            title: Text('Summary',
                style: TextStyle(
                  fontSize: buttonFont,
                  color: colors.text,
                )),
            onTap: () {
              Navigation().navigationReplace(context, const Summary());
            },
          ),
          ListTile(
            title: Text('Saved',
                style: TextStyle(
                  fontSize: buttonFont,
                  color: colors.text,
                )),
            onTap: () {
              Navigation().navigationReplace(context, const Saved());
            },
          ),
          ListTile(
            title: Text('Settings',
                style: TextStyle(
                  fontSize: buttonFont,
                  color: colors.text,
                )),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight / 3),
            child: ListTile(
              title: Text('Logout',
                  style: TextStyle(
                    fontSize: buttonFont,
                    color: colors.secondary,
                  )),
              onTap: () {
                Navigation().navigationReplace(context, const Login());
              },
            ),
          ),
        ],
      ),
    );
  }
}
