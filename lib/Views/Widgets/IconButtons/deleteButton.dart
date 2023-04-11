import 'package:flutter/material.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Views/Widgets/labelIcon.dart';

class DeleteButton extends StatelessWidget {
  DeleteButton({
    Key? key,
    required this.isSummary,
    required this.ss,
  }) : super(key: key);
  final bool isSummary;
  var ss;
  @override
  Widget build(BuildContext context) {
    return LabelIcon(
      icon: Icons.delete_forever,
      label: "Delete",
      onPress: () {
        // UserController().removeSummaryDB(isSummary, ss);
      },
    );
  }
}
