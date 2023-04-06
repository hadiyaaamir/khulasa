import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class ThemeRow extends StatelessWidget {
  const ThemeRow({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, ColorTheme> themes = context.watch<DarkMode>().getThemes();
    String selected = context.read<DarkMode>().theme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: getRow(themes, selected),
    );
  }

  List<Widget> getRow(Map<String, ColorTheme> themes, String selected) {
    List<Widget> circles = [];
    List<ColorTheme> values = themes.values.toList();
    List<String> keys = themes.keys.toList();
    for (var i = 0; i < themes.keys.length; i++) {
      circles.add(ThemeOption(
        color: values[i].secondary,
        isSelected: selected == keys[i],
        theme: keys[i],
      ));
    }

    return circles;
  }
}

//
//
//coloured circle option

class ThemeOption extends StatefulWidget {
  const ThemeOption({
    super.key,
    required this.color,
    required this.theme,
    required this.isSelected,
  });
  final Color color;
  final String theme;
  final bool isSelected;

  @override
  State<ThemeOption> createState() => _ThemeOptionState();
}

class _ThemeOptionState extends State<ThemeOption> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.read<DarkMode>().mode;

    return InkWell(
      child: Container(
        height: widget.isSelected ? 35 : 30,
        width: widget.isSelected ? 35 : 30,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
          border: Border.all(
              width: widget.isSelected ? 3 : 0,
              color:
                  widget.isSelected ? colors.background : Colors.transparent),
          boxShadow: [
            BoxShadow(blurRadius: 5, color: widget.color, spreadRadius: 0)
          ],
        ),
      ),
      onTap: () {
        context.read<DarkMode>().theme = widget.theme;
      },
    );
  }
}
