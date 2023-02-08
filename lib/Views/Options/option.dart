import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Saved/saved.dart';
import 'package:khulasa/Views/RSS/categories.dart';
import 'package:khulasa/Views/Summary/summary.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class Option extends StatefulWidget {
  const Option({super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: background,
      ),
      drawer: Drawer(
        child: Draw(),
      ),
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Btn(
              label: "RSS Feed",
              onPress: () =>
                  Navigation().navigation(context, const Categories()),
              background: primary,
              foreground: text,
              height: 160,
              font: largeFont,
            ),
            Btn(
              label: "Summary",
              onPress: () => Navigation().navigation(context, const Summary()),
              background: primary,
              foreground: text,
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
    );
  }
}
