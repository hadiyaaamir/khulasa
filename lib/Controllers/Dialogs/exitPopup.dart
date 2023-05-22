import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/button.dart';

import 'package:provider/provider.dart';

Future<bool> showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        ColorTheme colors = context.watch<DarkMode>().mode;
        return AlertDialog(
          backgroundColor: colors.background,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Do you want to exit?",
                style: TextStyle(color: colors.text),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const SizedBox(width: 15),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Btn(
                        label: 'No',
                        paddingVert: 0,
                        paddingHor: 0,
                        background: colors.primary,
                        height: 40,
                        onPress: () => Navigation().navigationPop(context)),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    child: Btn(
                        label: 'Yes',
                        paddingVert: 0,
                        paddingHor: 0,
                        height: 40,
                        onPress: () => exit(0)),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
