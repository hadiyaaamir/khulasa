import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:provider/provider.dart';

class SettingBtn extends StatelessWidget {
  const SettingBtn({
    super.key,
    required this.content,
    required this.isSelected,
  });

  final Widget content;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(30),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.background,
          border: Border.all(
              color: isSelected
                  ? isDarkMode
                      ? colors.text
                      : colors.secondary
                  : colors.primary,
              width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (isSelected) ...[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 3,
                offset: const Offset(2, 3), // changes position of shadow
              ),
            ],
          ],
        ),
        child: content,
      ),
    );
  }
}
