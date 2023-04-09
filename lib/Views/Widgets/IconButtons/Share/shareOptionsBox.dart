import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/IconButtons/Share/sharingOption.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareOptionsBox extends StatelessWidget {
  const ShareOptionsBox({super.key, required this.isRSSFeed});

  final bool isRSSFeed;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //heading
            Text(
              isRSSFeed
                  ? isEnglish
                      ? 'Share Article'
                      : ''
                  : isEnglish
                      ? 'Share Summary'
                      : '',
              style: TextStyle(
                color: colors.text,
                fontSize: isEnglish ? headingFont : headingFont + 4,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Divider
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Divider(color: colors.background),
            ),
            //Row of Social Media things
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SharingOption(
                    icon: FontAwesomeIcons.facebook,
                    text: 'Facebook',
                    onPress: () {},
                  ),
                  SharingOption(
                    icon: FontAwesomeIcons.instagram,
                    text: 'Instagram',
                    onPress: () {},
                  ),
                  SharingOption(
                    icon: FontAwesomeIcons.twitter,
                    text: 'Twitter',
                    onPress: () {},
                  ),
                  SharingOption(
                    icon: FontAwesomeIcons.whatsapp,
                    text: 'WhatsApp',
                    onPress: () {},
                  ),
                  SharingOption(
                    icon: FontAwesomeIcons.copy,
                    text: 'Copy',
                    onPress: () {},
                  ),
                  // SharingOption(icon: Icons),
                ],
              ),
            ),

            // Divider
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Divider(color: colors.background),
            ),
          ],
        ),
      ),
    );
  }
}
