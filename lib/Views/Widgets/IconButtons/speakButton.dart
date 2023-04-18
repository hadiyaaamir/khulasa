import 'package:flutter/material.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/HelperFunctions/tts.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class SpeakIconButton extends StatefulWidget {
  SpeakIconButton({
    super.key,
    required this.speakText,
    this.vertPadding = 12,
    this.iconColor,
    this.iconSize = iconRegular,
  });

  final String speakText;
  final double vertPadding;
  final Color? iconColor;
  final double iconSize;

  @override
  State<SpeakIconButton> createState() => _SpeakIconButtonState();
}

class _SpeakIconButtonState extends State<SpeakIconButton> {
  bool isSpeaking = false;
  bool started = false;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Wrap(
      spacing: 0,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: widget.vertPadding, horizontal: 5),
          child: InkWell(
            child: isSpeaking
                ? Icon(Icons.pause,
                    color: widget.iconColor ?? colors.text,
                    size: widget.iconSize)
                : started
                    ? Icon(Icons.play_arrow,
                        color: widget.iconColor ?? colors.text,
                        size: widget.iconSize)
                    : Icon(Icons.volume_up_rounded,
                        color: widget.iconColor ?? colors.text,
                        size: widget.iconSize),
            onTap: () async {
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
          ),
        ),

        //stop button - only if speaking
        if (started) ...[
          Padding(
            padding: EdgeInsets.symmetric(vertical: widget.vertPadding),
            child: InkWell(
              child: Icon(Icons.stop,
                  color: widget.iconColor ?? colors.text,
                  size: widget.iconSize),
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
