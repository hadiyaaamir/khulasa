import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Saved/saved.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Summary/linkSummary.dart';
import 'package:khulasa/Views/Summary/textSummary.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:provider/provider.dart';

class SavedMain extends StatefulWidget {
  const SavedMain({super.key});

  @override
  State<SavedMain> createState() => _SavedMainState();
}

class _SavedMainState extends State<SavedMain> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Scaffold(
      appBar: CustomAppBar(title: 'Summary'),
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
              const Expanded(
                child: TabBarView(
                  children: [ Saved(isSummary: true,), Saved(isSummary: false,)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
