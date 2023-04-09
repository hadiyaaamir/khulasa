import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class SharingOption extends StatelessWidget {
  const SharingOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onPress,
  });

  final IconData icon;
  final String text;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: colors.secondary,
            radius: 25,
            child: IconButton(
              icon: FaIcon(icon),
              onPressed: onPress,
              color: colors == blueDarkMode ? colors.text : colors.background,
            ),
          ),
          const SizedBox(height: 5),
          Text(text, style: TextStyle(fontSize: smallFont, color: colors.text)),
        ],
      ),
    );
  }
}
