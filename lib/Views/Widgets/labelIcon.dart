import 'package:flutter/material.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class LabelIcon extends StatelessWidget {
  const LabelIcon({
    super.key,
    required this.icon,
    required this.label,
    this.color = primary,
    required this.onPress,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Column(
        children: [
          Icon(icon, color: color),
          Text(
            label,
            style: TextStyle(fontSize: smallFont, color: color),
          )
        ],
      ),
    );
  }
}
