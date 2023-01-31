import 'package:flutter/material.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class Btn extends StatelessWidget {
  Btn({
    super.key,
    required this.label,
    required this.onPress,
    this.width,
    this.font = buttonFont,
    this.height = buttonHeight,
    this.foreground = text,
    this.background = secondary,
  });

  final Function() onPress;
  final String label;
  double font;
  Color foreground;
  Color background;
  double? width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: SizedBox(
        width: width ?? screenWidth,
        height: height,
        child: ElevatedButton(
          onPressed: onPress,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(foreground),
            backgroundColor: MaterialStateProperty.all<Color>(background),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: const BorderSide(color: secondary),
              ),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: font),
          ),
        ),
      ),
    );
  }
}
