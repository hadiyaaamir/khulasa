import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Summary/linkSummary.dart';
import 'package:khulasa/Views/Summary/textSummary.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
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
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: colors.background,
        foregroundColor: isDarkMode ? colors.text : colors.secondary,
        elevation: 0,
      ),
      drawer: Drawer(
        child: Draw(),
      ),
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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
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
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      labelColor: colors.text,
                      unselectedLabelColor: colors.text2,
                      tabs: const [Tab(text: 'Text'), Tab(text: 'Link')],
                      indicatorColor: colors.text,
                      indicatorWeight: 3),
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
    );
  }
}
