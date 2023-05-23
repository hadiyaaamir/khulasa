import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/IconButtons/Share/shareOptionsBox.dart';
import 'package:khulasa/Views/Widgets/IconButtons/labelIcon.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class ShareButton extends StatelessWidget {
  ShareButton({
    super.key,
    this.isRSSFeed = true,
    required this.content,
    this.isTranscript = false,
  });

  final bool isRSSFeed;
  final bool isTranscript;
  var content;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return LabelIcon(
      icon: Icons.share_rounded,
      label: "Share",
      onPress: () async {
        await showModalBottomSheet(
          context: context,
          backgroundColor: colors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          builder: (BuildContext context) => ShareOptionsBox(
            isRSSFeed: isRSSFeed,
            content: content,
            isTranscript: isTranscript,
          ),
          isScrollControlled: true,
          // constraints: BoxConstraints(maxHeight: screenHeight * 2 / 3),
        );
      },
    );
  }
}
