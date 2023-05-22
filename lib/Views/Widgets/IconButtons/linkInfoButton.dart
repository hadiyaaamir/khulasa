import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Dialogs/linkInfoPopup.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:provider/provider.dart';

class LinkInfoButton extends StatelessWidget {
  const LinkInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    return IconButton(
      onPressed: () {
        showLinkInfoPopup(context);
      },
      icon: Icon(
        Icons.info_outline_rounded,
        color: colors.secondary,
      ),
    );
  }
}
