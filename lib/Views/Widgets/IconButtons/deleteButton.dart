import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Views/Saved/savedOptions.dart';
import 'package:khulasa/Views/Widgets/IconButtons/labelIcon.dart';
import 'package:provider/provider.dart';

class DeleteButton extends StatelessWidget {
  DeleteButton({
    Key? key,
    required this.isSummary,
    this.isTranscript = false,
    this.ss,
  }) : super(key: key);
  final bool isSummary;
  final bool isTranscript;
  var ss;
  @override
  Widget build(BuildContext context) {
    return LabelIcon(
      icon: Icons.delete_forever,
      label: "Delete",
      onPress: () {
        isSummary
            ? context.read<UserController>().removeSummary(ss)
            : isTranscript
                ? context.read<UserController>().removeTranscription(ss)
                : context.read<UserController>().removeArticle(ss);
        Navigation().navigationReplace(
          context,
          SavedMain(
            initIndex: isSummary
                ? 0
                : isTranscript
                    ? 2
                    : 1,
          ),
        );
      },
    );
  }
}
