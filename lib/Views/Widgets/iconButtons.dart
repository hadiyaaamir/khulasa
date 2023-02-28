import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/tts.dart';
import 'package:khulasa/Views/Widgets/labelIcon.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class SpeakIconButton extends StatefulWidget {
  SpeakIconButton({super.key, required this.speakText});

  final String speakText;

  @override
  State<SpeakIconButton> createState() => _SpeakIconButtonState();
}

class _SpeakIconButtonState extends State<SpeakIconButton> {
  bool isSpeaking = false;
  bool started = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0,
      children: [
        IconButton(
          icon: isSpeaking
              ? const Icon(Icons.pause, color: text)
              : started
                  ? const Icon(Icons.play_arrow, color: text)
                  : const Icon(Icons.volume_up_rounded, color: text),
          onPressed: () async {
            setTtsConfig();
            flutterTts.setLanguage("ur-PK");
            isSpeaking
                ? flutterTts.pause()
                : flutterTts.speak(widget.speakText);
            setState(() {
              started = true;
              isSpeaking = !isSpeaking;
            });
            flutterTts.setCompletionHandler(() {
              setState(() {
                isSpeaking = false;
                started = false;
              });
            });
          },
          color: text,
          iconSize: largeFont,
        ),

        //stop button - only if speaking
        if (started) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: InkWell(
              child: const Icon(Icons.stop, color: text),
              onTap: () {
                flutterTts.stop();
                setState(() {
                  isSpeaking = false;
                  started = false;
                });
              },
            ),
          ),
        ]
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LabelIcon(
      icon: Icons.share_rounded,
      label: "Share",
      onPress: () {},
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LabelIcon(
      icon: Icons.save,
      label: "Save",
      onPress: () {},
    );
  }
}
