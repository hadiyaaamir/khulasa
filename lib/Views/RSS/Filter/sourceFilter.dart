import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:khulasa/constants/sources.dart';
import 'package:provider/provider.dart';

class SourceFilter extends StatelessWidget {
  const SourceFilter({super.key});

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          child: Text(
            'News Sources',
            style: TextStyle(color: colors.text, fontSize: buttonFont),
          ),
        ),
        Wrap(
          children: List.generate(
            sources.length,
            (index) => SourceCheckbox(source: sources[index]),
          ),
        ),
      ],
    );
  }
}

class SourceCheckbox extends StatefulWidget {
  const SourceCheckbox({super.key, required this.source});

  final Source source;

  @override
  State<SourceCheckbox> createState() => SourceCheckboxState();
}

class SourceCheckboxState extends State<SourceCheckbox> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(right: 5, bottom: 5),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: isDarkMode ? colors.background : colors.text,
                  width: 2),
              color: isChecked ? colors.secondary : colors.primary,
              borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              widget.source.source,
              style: TextStyle(
                color: isChecked ? colors.background : colors.text,
                fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            isChecked = !isChecked;
          });
        },
      ),
    );
  }
}
