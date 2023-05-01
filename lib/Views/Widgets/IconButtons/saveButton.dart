import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedArticle.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/user.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/labelIcon.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  SaveButton({
    Key? key,
    required this.isSummary,
    required this.ss,
  }) : super(key: key);
  final bool isSummary;
  var ss;

  _displayDialog(BuildContext context) async {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;
    appUser user = context.watch<UserController>().currentUser;
    TextEditingController titleController = TextEditingController();
    titleController.text = "Summary" + DateTime.now().toString();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: colors.background,
            title: Text(
              'Save Summary',
              style: TextStyle(color: colors.text),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0))),
            contentPadding: const EdgeInsets.all(20),
            content: Container(
              height: screenHeight / 2,
              child: Column(
                children: [
                  textField(
                    label: isEnglish ? "Title" : "title in urdu",
                    controller: titleController,
                    password: true,
                    allowEmpty: false,
                    validate: (value) {
                      return null;
                    },
                  ),
                  Row(children: [
                    Btn(
                        // background: colors.primary,
                        label: 'Save',
                        onPress: () {
                          (ss as savedSummary).title = titleController.text;
                          context
                              .read<UserController>()
                              .addSummary(ss as savedSummary);
                          Navigator.of(context).pop();
                        }),
                    Btn(
                        // background: colors.primary,
                        label: 'Cancel',
                        onPress: () {
                          Navigator.of(context).pop();
                        }),
                  ]),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return LabelIcon(
      icon: Icons.save,
      label: "Save",
      onPress: () {
        isSummary
            ? _displayDialog(context)
            : context.read<UserController>().addArticle(ss as savedArticle);
        // UserController().addSummaryDB(isSummary, ss);
        // print("Save summary/article" + ss.email);
      },
    );
  }
}
