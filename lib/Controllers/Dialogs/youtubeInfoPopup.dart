import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:khulasa/constants/sources.dart';

import 'package:provider/provider.dart';

showYoutubeInfoPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        ColorTheme colors = context.watch<DarkMode>().mode;
        bool isEnglish = context.watch<Language>().isEnglish;

        List<String> steps = [
          "Below the video player, you'll find various options.",
          "Look for the \"Share\" button and tap on it.",
          "A share panel will appear with different sharing options.",
          "Look for the option that says \"Copy Link\" or similar.",
          "Tap on the\"Copy Link\" option.",
          "The YouTube video link will be copied to your device's clipboard.",
        ];

        List<String> stepsUrdu = [
          "١. ویڈیو پلیئر کے نیچے مختلف اختیارات دستیاب ہوں گے۔",
          "٢. شیئر بٹن تلاش کریں اور اس پر ٹیپ کریں۔",
          "٣. ایک شیئر پینل ظاہر ہوگا جس میں مختلف شیئرنگ اختیارات ہوں گی۔",
          "٤. لنک کاپی کریں یا مماثل آپشن تلاش کریں۔",
          "٥. لنک کاپی کریں آپشن پر ٹیپ کریں۔",
          "٦. یوٹیوب ویڈیو لنک آپ کی ڈیوائس کے کلپ بورڈ پر کاپی ہوگا۔",
        ];

        return AlertDialog(
          backgroundColor: colors.background,
          content: Directionality(
            textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getCloseButton(context, colors.secondary, isEnglish),
                Text(
                  isEnglish
                      ? "How to Get Youtube Link?"
                      : 'یوٹیوب لنک کیسے حاصل کریں؟',
                  style: TextStyle(
                      color: colors.text,
                      fontSize: headingFont,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    steps.length,
                    (index) => Column(
                      children: [
                        Text(
                            isEnglish
                                ? '${index + 1}. ${steps[index]}'
                                : stepsUrdu[index],
                            style: TextStyle(color: colors.text)),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                )
                // SizedBox(
                //   height: screenHeight / 3,
                //   child: ListView.builder(
                //     itemCount: sources.length,
                //     itemBuilder: (context, index) =>
                //         Text(sources[index].source),
                //   ),
                // ),
              ],
            ),
          ),
        );
      });
}

_getCloseButton(context, Color color, bool isEnglish) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      alignment:
          isEnglish ? FractionalOffset.topRight : FractionalOffset.topLeft,
      child: GestureDetector(
        child: Icon(
          Icons.clear,
          color: color,
          size: headingFont,
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    ),
  );
}
