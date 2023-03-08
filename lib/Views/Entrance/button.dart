import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class Btn extends StatelessWidget {
  Btn({
    super.key,
    required this.label,
    required this.onPress,
    this.width,
    this.font = buttonFont,
    this.height = buttonHeight,
    this.foreground,
    this.background,
    this.icon,
    this.paddingVert = 30,
    this.paddingHor = 50,
    this.align = Alignment.center,
  });

  final Function() onPress;
  final String label;
  double font;
  Color? foreground;
  Color? background;
  double? width;
  double height;
  final IconData? icon;
  double paddingVert;
  double paddingHor;
  Alignment align;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Align(
      alignment: align,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: paddingVert, horizontal: paddingHor),
        child: SizedBox(
          width: width ?? screenWidth,
          height: height,
          child: ElevatedButton(
            onPressed: onPress,
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(foreground ?? colors.text),
              backgroundColor: MaterialStateProperty.all<Color>(
                  background ?? colors.secondary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: colors.secondary),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (icon != null) ...[Icon(icon, size: font + 2)],
                Text(label, style: TextStyle(fontSize: font)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
