import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/Saved/savedSummary.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final List<savedSummary> items = [
    savedSummary(
        title: "FIFA Drama",
        savedOn: DateTime.now(),
        summary: "Hi, my name is jaw"),
    savedSummary(
        title: "FIFA Drama",
        savedOn: DateTime.now(),
        summary: "Hi, my name is jaw")
  ];
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: colors.background,
      ),
      drawer: Drawer(
        child: Draw(),
      ),
      backgroundColor: colors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Saved Summaries",
              style: TextStyle(
                  fontSize: headingFont,
                  color: colors.text,
                  fontWeight: FontWeight.bold),
            ),
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
                          color: colors.secondary, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Saved on: ${items[index].savedOn.day}/${items[index].savedOn.month}/${items[index].savedOn.year}',
                      style: TextStyle(color: colors.secondary),
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: colors.secondary,
                    ),
                    onTap: () => Navigation().navigation(
                      context,
                      SavedSummary(
                        summary: items[index],
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
