import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/savedArticle.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/Widgets/labelIcon.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  SaveButton({
    Key? key,
    required this.isSummary,
    required this.ss,
  }) : super(key: key);
  final bool isSummary;
  var ss;
  @override
  Widget build(BuildContext context) {
    return LabelIcon(
      icon: Icons.save,
      label: "Save",
      onPress: () {
        isSummary
            ? context.read<UserController>().addSummary(ss as savedSummary)
            : context.read<UserController>().addArticle(ss as savedArticle);
        // UserController().addSummaryDB(isSummary, ss);
      },
    );
  }
}
