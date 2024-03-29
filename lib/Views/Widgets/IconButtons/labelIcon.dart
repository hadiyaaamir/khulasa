import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class LabelIcon extends StatelessWidget {
  const LabelIcon({
    super.key,
    required this.icon,
    required this.label,
    this.color,
    required this.onPress,
  });

  final IconData icon;
  final String label;
  final Color? color;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          Icon(
            icon,
            color: color ?? (isDarkMode ? colors.primary : colors.secondary),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: smallFont,
              color: color ?? (isDarkMode ? colors.primary : colors.secondary),
            ),
          )
        ],
      ),
    );
  }
}
