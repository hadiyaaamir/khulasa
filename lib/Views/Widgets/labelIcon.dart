import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class LabelIcon extends StatelessWidget {
  const LabelIcon(
      {super.key,
      required this.icon,
      required this.label,
      this.color = primary});

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color),
        Text(
          label,
          style: TextStyle(fontSize: smallFont, color: color),
        )
      ],
    );
  }
}
