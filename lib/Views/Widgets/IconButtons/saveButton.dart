import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Dialogs/saveSummaryPopup.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/savedArticle.dart';
import 'package:khulasa/Views/Widgets/IconButtons/labelIcon.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  SaveButton({
    Key? key,
    required this.isSummary,
    this.isTranscript = false,
    required this.ss,
  }) : super(key: key);

  final bool isSummary;
  final bool isTranscript;
  var ss;

  @override
  Widget build(BuildContext context) {
    return LabelIcon(
      icon: Icons.save,
      label: "Save",
      onPress: () {
        isSummary
            ? showSummarySavePopup(context: context, ss: ss)
            : isTranscript
                ? showSummarySavePopup(
                    context: context, ss: ss, isSummary: false)
                : context.read<UserController>().addArticle(ss as savedArticle);
        // UserController().addSummaryDB(isSummary, ss);
        // print("Save summary/article" + ss.email);
      },
    );
  }
}
