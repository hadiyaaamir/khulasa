import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Backend/dateFormat.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/RSS/rssTile.dart';
import 'package:khulasa/Views/Saved/savedTile.dart';
import 'package:khulasa/Views/Saved/summaryView.dart';
import 'package:provider/provider.dart';

class Saved extends StatefulWidget {
  const Saved({
    Key? key,
    required this.isSummary,
    this.isTanscript = false,
  }) : super(key: key);

  final bool isSummary;
  final bool isTanscript;

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    final List items = widget.isSummary
        ? context.watch<UserController>().savdSummary
        : widget.isTanscript
            ? context.watch<UserController>().savdTranscripts
            : context.watch<UserController>().savdArticles;
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Directionality(
      textDirection: isEnglish || (!widget.isSummary && !widget.isTanscript)
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colors.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  itemCount: items.length,
                  itemBuilder: (context, index) => widget.isSummary
                      ? SavedTile(isTranscript: false, savedItem: items[index])
                      : widget.isTanscript
                          ? SavedTile(
                              isTranscript: true, savedItem: items[index])
                          : RssTile(
                              title: items[index].art.title,
                              source: isEnglish
                                  ? items[index].art.link.source.source
                                  : items[index].art.link.source.sourceUrdu,
                              date: items[index].art.date,
                              speakText:
                                  "${items[index].art.title}...${items[index].art.content}",
                              summary: items[index].art.summary,
                              art: items[index],
                              isSaved: true,
                            ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
