import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/Saved/savedSummary.dart';
import 'package:khulasa/constants/colors.dart';
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
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Saved Summaries",
              style: TextStyle(
                  fontSize: headingFont,
                  color: text,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                itemCount: items.length,
                itemBuilder: (context, index) => Card(
                  color: primary,
                  child: ListTile(
                    title: Text(
                      items[index].title,
                      style: const TextStyle(
                          color: secondary, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Saved on: ${items[index].savedOn.day}/${items[index].savedOn.month}/${items[index].savedOn.year}',
                      style: const TextStyle(color: secondary),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: secondary,
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
