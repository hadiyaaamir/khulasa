import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/Models/transcript.dart';

class SharingController {
  FlutterShareMe fsm = FlutterShareMe();

  shareOnSocial({
    required String social,
    isRSSFeed = false,
    isTranscript = false,
    required var content,
    bool onlyLink = false,
    bool isAdvert = true,
  }) {
    String message = "";

    isRSSFeed
        ? message = getRSSMessage(
            art: content as article, onlyLink: onlyLink, advert: isAdvert)
        : isTranscript
            ? message = getTranscriptMessage(transcript: content as Transcript)
            : message =
                getSummaryMessage(summary: content as String, advert: isAdvert);

    switch (social) {
      case 'whatsapp':
        fsm.shareToWhatsApp(msg: message);
        break;
      case 'system':
        fsm.shareToSystem(msg: message);
        // fsm.shareToFacebook(
        //     msg: message, url: 'google.com'); //add url to app store later
        break;
      case 'twitter':
        fsm.shareToTwitter(msg: message);
        break;
      case 'copy':
        Clipboard.setData(ClipboardData(text: message)).then((_) {
          Fluttertoast.showToast(msg: 'Copied to clipboard!');
        });
        break;
    }
  }

  String getSummaryMessage({required String summary, bool advert = true}) {
    String adText =
        "Khulasa is great for summarising long articles to make them more readable."
        " Here's a summary I just generated: \n\n";
    return advert ? adText + summary : summary;
  }

  String getTranscriptMessage(
      {required Transcript transcript, bool advert = true}) {
    String adText =
        "Khulasa can be used to transcribe Youtube videos and mp3 files in Urdu."
        " Here's a transcription I just generated: \n\n";

    String content = "Summary:\n ${transcript.summary}\n\n"
        "Complete transcription:\n ${transcript.transcription}\n ";

    return advert ? adText + content : content;
  }

  String getRSSMessage({
    required article art,
    bool advert = true,
    required bool onlyLink,
  }) {
    String adText =
        "I use the Khulasa RSS Feed to keep myself updated on the latest news."
        " Here's an interesting article I read recently: \n\n";

    String content = "${art.title} \n\n"
        "Summary:\n ${art.summary}\n\n"
        "Complete article:\n ${art.content}\n ";

    if (onlyLink) {
      return "The Khulasa RSS Feed keeps me updated on the lastest news. "
          "Here's a link to a good article: \n"
          "${art.link!.link}";
    }

    return advert ? adText + content : content;
  }
}
