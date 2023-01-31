import 'package:flutter/material.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class Btn extends StatelessWidget {
  Btn({
    super.key,
    required this.label,
    required this.onPress,
    this.width,
    this.height = buttonHeight,
  });

  final Function() onPress;
  final String label;
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
            foregroundColor: MaterialStateProperty.all<Color>(text),
            backgroundColor: MaterialStateProperty.all<Color>(secondary),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: const BorderSide(color: secondary),
              ),
            ),
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: buttonFont),
          ),
        ),
      ),
    );
  }
}
