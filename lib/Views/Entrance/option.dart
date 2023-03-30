import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/RSS/rssFeed.dart';
import 'package:khulasa/Views/Saved/saved.dart';
import 'package:khulasa/Views/RSS/categories.dart';
import 'package:khulasa/Views/Summary/summary.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class Option extends StatefulWidget {
  const Option({super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    return Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(
        child: Draw(),
      ),
      backgroundColor: colors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Btn(
                label: "Summary",
                onPress: () =>
                    Navigation().navigation(context, const Summary()),
                background: colors.primary,
                foreground: colors.text,
                height: 160,
                font: largeFont,
              ),
              Btn(
                label: "RSS Feed",
                onPress: () =>
                    Navigation().navigation(context, const RssFeed()),
                background: colors.primary,
                foreground: colors.text,
                height: 160,
                font: largeFont,
              ),

              // Btn(
              //   label: "Saved Summary",
              //   onPress: () => Navigation().navigation(context, const Saved()),
              //   background: primary,
              //   foreground: text,
              //   height: 60,
              //   font: largeFont,
              // )
            ],
          ),
        ),
      ),
    );
  }
}