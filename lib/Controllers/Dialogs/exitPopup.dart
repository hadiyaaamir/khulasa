import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/button.dart';

import 'package:provider/provider.dart';

Future<bool> showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        ColorTheme colors = context.watch<DarkMode>().mode;
        bool isEnglish = context.watch<Language>().isEnglish;

        return Directionality(
          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: colors.background,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEnglish
                      ? "Do you want to exit?"
                      : "کیا آپ ایپ سے باہر نکلنا چاہتے ہیں؟",
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
                          label: isEnglish ? 'No' : 'نہیں',
                          paddingVert: 0,
                          paddingHor: 0,
                          background: colors.primary,
                          height: 40,
                          onPress: () => Navigation().navigationPop(context)),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 100),
                      child: Btn(
                          label: isEnglish ? 'Yes' : 'ہاں',
                          paddingVert: 0,
                          paddingHor: 0,
                          height: 40,
                          onPress: () => exit(0)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
