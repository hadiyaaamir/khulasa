import 'package:flutter/material.dart';
import 'package:khulasa/constants/colors.dart';

class ColorTheme {
  Color background;
  Color primary;
  Color secondary;
  Color text; // used for headings
  Color text2;
  Color caution;

  ColorTheme({
    required this.background,
    required this.primary,
    required this.secondary,
    required this.text,
    required this.text2,
    required this.caution,
  });
}
