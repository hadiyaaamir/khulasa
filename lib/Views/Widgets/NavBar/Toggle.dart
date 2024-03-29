import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:provider/provider.dart';

const List<Widget> options = <Widget>[
  Text('English'),
  Text(
    'اردو',
    style: TextStyle(fontWeight: FontWeight.bold),
  ),
];

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool vertical = false;
  List<bool> selected = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    selected = <bool>[isEnglish, !isEnglish];

    return ToggleButtons(
      direction: vertical ? Axis.vertical : Axis.horizontal,
      onPressed: (int index) {
        // setState(() {
        // The button that is tapped is set to true, and the others to false.
        // for (int i = 0; i < selected.length; i++) {
        //   selected[i] = i == index;
        // }
        // });
        if (index == 0 && !selected[index]) {
          context.read<Language>().toEnglish();
        } else if (index == 1 && !selected[index]) {
          context.read<Language>().toUrdu();
        }
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      borderWidth: 3,
      borderColor: colors.text2,
      selectedBorderColor: colors.secondary,
      selectedColor: colors.text,
      fillColor: colors.primary,
      color: colors.text,
      constraints: const BoxConstraints(
        minHeight: 30.0,
        minWidth: 60.0,
      ),
      isSelected: selected,
      children: options,
    );
  }
}
