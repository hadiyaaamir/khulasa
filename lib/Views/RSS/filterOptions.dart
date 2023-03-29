import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class FilterOptionsBox extends StatelessWidget {
  const FilterOptionsBox({super.key});

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Container(
      height: screenHeight / 2,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            'Apply Filters',
            style: TextStyle(color: colors.text, fontSize: headingFont),
          ),
        ],
      ),
    );
  }
}
