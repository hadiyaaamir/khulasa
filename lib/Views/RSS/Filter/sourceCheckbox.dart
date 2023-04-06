import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:provider/provider.dart';

class SourceCheckbox extends StatefulWidget {
  const SourceCheckbox({
    super.key,
    required this.source,
    required this.addSource,
    required this.removeSource,
    required this.isChecked,
  });

  final Source source;
  final Function(Source) addSource;
  final Function(Source) removeSource;
  final bool isChecked;

  @override
  State<SourceCheckbox> createState() => SourceCheckboxState();
}

class SourceCheckboxState extends State<SourceCheckbox> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    bool isChecked = widget.isChecked;

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
                color: isChecked
                    ? colors == blueDarkMode
                        ? colors.text
                        : colors.background
                    : colors.text,
                fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            isChecked
                ? widget.removeSource(widget.source)
                : widget.addSource(widget.source);
          });
        },
      ),
    );
  }
}
