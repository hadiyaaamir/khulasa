import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Controllers/sharingController.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/IconButtons/Share/sharingOption.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class ShareOptionsBox extends StatelessWidget {
  ShareOptionsBox({
    super.key,
    required this.isRSSFeed,
    required this.content,
    this.isTranscript = false,
  });

  final bool isRSSFeed;
  final bool isTranscript;
  var content;

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
                      : 'خبر کا اشتراک کریں'
                  : isTranscript
                      ? isEnglish
                          ? 'Share Transcription'
                          : 'تحریر کا اشتراک کریں'
                      : isEnglish
                          ? 'Share Summary'
                          : 'خلاصے کا اشتراک کریں',
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
                  // SharingOption(
                  //   icon: FontAwesomeIcons.instagram,
                  //   text: 'Instagram',
                  //   onPress: () {},
                  // ),
                  SharingOption(
                    icon: FontAwesomeIcons.copy,
                    text: 'Copy',
                    onPress: () {
                      SharingController().shareOnSocial(
                        social: 'copy',
                        content: content,
                        isRSSFeed: isRSSFeed,
                        isTranscript: isTranscript,
                        isAdvert: false,
                      );
                    },
                  ),
                  SharingOption(
                    icon: FontAwesomeIcons.twitter,
                    text: 'Twitter',
                    onPress: () {
                      SharingController().shareOnSocial(
                        social: 'twitter',
                        content: content,
                        isRSSFeed: isRSSFeed,
                        isTranscript: isTranscript,
                        onlyLink: true,
                      );
                    },
                  ),
                  SharingOption(
                    icon: FontAwesomeIcons.whatsapp,
                    text: 'WhatsApp',
                    onPress: () {
                      SharingController().shareOnSocial(
                        social: 'whatsapp',
                        content: content,
                        isRSSFeed: isRSSFeed,
                        isTranscript: isTranscript,
                      );
                    },
                  ),
                  SharingOption(
                    icon: Icons.mobile_screen_share,
                    text: 'Other',
                    onPress: () async {
                      SharingController().shareOnSocial(
                        social: 'system',
                        content: content,
                        isRSSFeed: isRSSFeed,
                        isTranscript: isTranscript,
                      );
                    },
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
