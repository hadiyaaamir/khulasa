import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Summary/linkSummary.dart';
import 'package:khulasa/Views/Summary/textSummary.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:provider/provider.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: isEnglish ? 'Summary' : "خلاصہ"),
        drawer: const Drawer(child: Draw()),
        backgroundColor: colors.background,
        body: Center(
          child: DefaultTabController(
            length: 2, // length of tabs
            initialIndex: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      //This is for background color
                      color: Colors.white.withOpacity(0.0),

                      //This is for bottom border that is needed
                      border: Border(
                        bottom: BorderSide(color: colors.primary, width: 3),
                      ),
                    ),
                    child: TabBar(
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      labelColor: colors.text,
                      unselectedLabelColor: colors.text2,
                      tabs: [
                        Tab(text: isEnglish ? 'Text' : 'اردو'),
                        Tab(text: isEnglish ? 'Link' : 'اردو'),
                      ],
                      indicatorColor: colors.text,
                      indicatorWeight: 3,
                    ),
                  ),
                ),
                //height of TabBarView
                Expanded(
                  child: TabBarView(
                    children: [TextSummary(), LinkSummary()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
