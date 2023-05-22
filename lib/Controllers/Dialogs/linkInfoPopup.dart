import 'dart:io';

import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:khulasa/constants/sources.dart';

import 'package:provider/provider.dart';

showLinkInfoPopup(context) async {
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
              _getCloseButton(context, colors.secondary),
              Text(
                "Supported News Sources",
                style: TextStyle(
                    color: colors.text,
                    fontSize: headingFont,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  sources.length,
                  (index) => Text('\u2022   ${sources[index].source}'),
                ),
              )
              // SizedBox(
              //   height: screenHeight / 3,
              //   child: ListView.builder(
              //     itemCount: sources.length,
              //     itemBuilder: (context, index) =>
              //         Text(sources[index].source),
              //   ),
              // ),
            ],
          ),
        );
      });
}

_getCloseButton(context, Color color) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      alignment: FractionalOffset.topRight,
      child: GestureDetector(
        child: Icon(
          Icons.clear,
          color: color,
          size: headingFont,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
