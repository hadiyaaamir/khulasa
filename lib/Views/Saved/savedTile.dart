import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Backend/dateFormat.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Saved/summaryView.dart';
import 'package:khulasa/Views/Saved/transcriptView.dart';
import 'package:provider/provider.dart';

class SavedTile extends StatelessWidget {
  SavedTile({
    super.key,
    required this.isTranscript,
    required this.savedItem,
  });

  final bool isTranscript;
  var savedItem;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Card(
      color: colors.primary,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
        title: Text(
          savedItem.title,
          style: TextStyle(color: colors.text, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${isEnglish ? 'Saved on' : 'تاریخ محفوظ'}: '
          '${DateFormatter().formatDate(savedItem.savedOn, isEnglish)}',
          style: TextStyle(color: colors.text2),
        ),
        trailing: Icon(
          isEnglish
              ? Icons.keyboard_arrow_right_rounded
              : Icons.keyboard_arrow_left_rounded,
          color: colors.text2,
        ),
        onTap: () => Navigation().navigation(
            context,
            isTranscript
                ? TranscriptView(transcript: savedItem)
                : SummaryView(summary: savedItem)),
      ),
    );
  }
}
