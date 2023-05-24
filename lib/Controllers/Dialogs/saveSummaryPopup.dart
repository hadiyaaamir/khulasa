import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Controllers/userController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/savedSummary.dart';
import 'package:khulasa/Models/savedTranscript.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/Views/Widgets/textfield.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

Future<bool> showSummarySavePopup(
    {context, var ss, bool isSummary = true}) async {
  TextEditingController titleController = TextEditingController();
  titleController.text =
      isSummary ? "Summary ${DateTime.now()}" : "Transcript ${DateTime.now()}";

  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        ColorTheme colors = context.watch<DarkMode>().mode;
        bool isEnglish = context.watch<Language>().isEnglish;

        return Directionality(
          textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
          child: AlertDialog(
            backgroundColor: colors.background,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSummary
                      ? isEnglish
                          ? "Save Summary"
                          : "خلاصہ محفوظ کریں"
                      : isEnglish
                          ? "Save Transcript"
                          : "تحریر محفوظ کریں",
                  style: TextStyle(color: colors.text, fontSize: headingFont),
                ),
                const SizedBox(height: 20),
                textField(
                  label: isEnglish ? "Title" : "عنوان",
                  paddingHor: 0,
                  controller: titleController,
                  allowEmpty: false,
                  validate: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const SizedBox(width: 15),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 110),
                      child: Btn(
                          label: isEnglish ? 'Cancel' : 'منسوخ کریں',
                          paddingVert: 0,
                          paddingHor: 0,
                          background: colors.primary,
                          height: 40,
                          onPress: () => Navigation().navigationPop(context)),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 110),
                      child: Btn(
                          label: isEnglish ? 'Save' : 'محفوظ کریں',
                          paddingVert: 0,
                          paddingHor: 0,
                          height: 40,
                          onPress: () {
                            if (isSummary) {
                              (ss as savedSummary).title = titleController.text;
                              context
                                  .read<UserController>()
                                  .addSummary(ss as savedSummary);
                            } else {
                              (ss as savedTranscript).title =
                                  titleController.text;
                              context
                                  .read<UserController>()
                                  .addTranscription(ss as savedTranscript);
                            }

                            Navigation().navigationPop(context);
                          }),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
