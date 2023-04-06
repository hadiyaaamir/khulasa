import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Controllers/savedProvider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/Widgets/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:khulasa/Views/Saved/savedSummary.dart';
import 'package:provider/provider.dart';

class Saved extends StatefulWidget {
  const Saved({
    Key? key,
    required this.isSummary,
  }) : super(key: key);

  final bool isSummary;

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    final List<savedSummary> items = widget.isSummary
        ? context.watch<savedProvider>().savdSummary
        : context.watch<savedProvider>().savdArticles;
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    return Scaffold(
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
                itemBuilder: (context, index) => Card(
                  color: colors.primary,
                  child: ListTile(
                    title: Text(
                      items[index].title,
                      style: TextStyle(
                          color: colors.text, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Saved on: ${items[index].savedOn.day}/${items[index].savedOn.month}/${items[index].savedOn.year}',
                      style: TextStyle(color: colors.text2),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: colors.text2,
                    ),
                    onTap: () => Navigation().navigation(
                      context,
                      SavedSummary(
                        summary: items[index],
                        isSummary: widget.isSummary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
