import 'package:flutter/material.dart';
import 'package:khulasa/Models/summary.dart';
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
              style: TextStyle(fontSize: headingFont, color: text),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemCount: items.length,
                itemBuilder: (context, index) => Card(
                  color: primary,
                  child: ListTile(
                    title: Text('${items[index].title}'),
                    subtitle: Text(
                        'Saved on: ${items[index].savedOn.day}/${items[index].savedOn.month}/${items[index].savedOn.year}'),
                    trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {},
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
