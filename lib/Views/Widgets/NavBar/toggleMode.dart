import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:provider/provider.dart';

class ToggleMode extends StatefulWidget {
  const ToggleMode({super.key});

  @override
  State<ToggleMode> createState() => _ToggleModeState();
}

class _ToggleModeState extends State<ToggleMode> {
  @override
  Widget build(BuildContext context) {
    // ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: darkBlue,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: isDarkMode ? white : yellow,
              spreadRadius: 0)
        ],
      ),
      child: IconButton(
        onPressed: () {
          context.read<DarkMode>().toggleMode();
        },
        icon: Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: isDarkMode ? white : yellow,
        ),
      ),
    );
  }
}
