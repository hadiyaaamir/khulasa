import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Dialogs/linkInfoPopup.dart';
import 'package:khulasa/Controllers/Dialogs/youtubeInfoPopup.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:provider/provider.dart';

class LinkInfoButton extends StatelessWidget {
  const LinkInfoButton({super.key, this.isTranscript = false});

  final bool isTranscript;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return IconButton(
      onPressed: () {
        isTranscript
            ? showYoutubeInfoPopup(context)
            : showLinkInfoPopup(context);
      },
      icon: Icon(
        Icons.info_outline_rounded,
        color: colors.secondary,
      ),
    );
  }
}
