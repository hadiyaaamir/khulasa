import 'dart:io';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

Future<bool> showFilterPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        ColorTheme colors = context.watch<DarkMode>().mode;

        return AlertDialog(
          backgroundColor: colors.background,
          title: Text(
            'Apply Filters',
            style: TextStyle(color: colors.text),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          contentPadding: const EdgeInsets.all(20),
          content: Container(
            height: screenHeight / 2,
            child: Column(
              children: [
                Btn(
                    // background: colors.primary,
                    label: 'Apply Filters',
                    onPress: () {
                      Navigator.of(context).pop(true);
                    }),
              ],
            ),
          ),
        );
      });
}
