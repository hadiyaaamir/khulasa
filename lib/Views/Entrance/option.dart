import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/dialog.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
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
    bool isEnglish = context.watch<Language>().isEnglish;

    return WillPopScope(
      onWillPop: () async => showExitPopup(context),
      child: Directionality(
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(),
          drawer: const Drawer(child: Draw()),
          backgroundColor: colors.background,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Btn(
                    label: isEnglish ? "Summary" : "خلاصہ",
                    onPress: () =>
                        Navigation().navigation(context, const Summary()),
                    background: colors.primary,
                    foreground: colors.text,
                    height: 160,
                    font: largeFont,
                  ),
                  Btn(
                    label: isEnglish ? "RSS Feed" : "آر ایس ایس فیڈ",
                    onPress: () =>
                        Navigation().navigation(context, const Categories()),
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
        ),
      ),
    );
  }
}
