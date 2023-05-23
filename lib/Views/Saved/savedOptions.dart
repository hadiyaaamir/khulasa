import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Entrance/homePage.dart';
import 'package:khulasa/Views/Saved/saved.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:provider/provider.dart';

class SavedMain extends StatefulWidget {
  const SavedMain({super.key, this.initIndex = 0});

  final int initIndex;

  @override
  State<SavedMain> createState() => _SavedMainState();
}

class _SavedMainState extends State<SavedMain> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return WillPopScope(
      onWillPop: () async =>
          Navigation().navigationReplace(context, const HomePage()),
      child: Directionality(
        textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: CustomAppBar(title: isEnglish ? 'Saved' : 'محفوظ'),
          drawer: const Drawer(child: Draw()),
          backgroundColor: colors.background,
          body: Center(
            child: DefaultTabController(
              length: 3, // length of tabs
              initialIndex: widget.initIndex,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                          tabs: [
                            Tab(text: isEnglish ? 'Summaries' : 'خلاصے'),
                            Tab(text: isEnglish ? 'Articles' : 'خبریں'),
                            Tab(text: isEnglish ? 'Transcripts' : 'تحریریں'),
                          ],
                          indicatorColor: colors.text,
                          indicatorWeight: 3),
                    ),
                  ),
                  //height of TabBarView
                  const Expanded(
                    child: TabBarView(
                      children: [
                        Saved(isSummary: true),
                        Saved(isSummary: false),
                        Saved(isSummary: false, isTanscript: true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
