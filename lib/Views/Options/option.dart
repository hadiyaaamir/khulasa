import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/Views/Summary/summary.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class Option extends StatefulWidget {
  const Option({super.key});

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Btn(
              label: "RSS Feed",
              onPress: () {},
              background: primary,
              foreground: text,
              height: 160,
              font: largeFont,
            ),
            Btn(
              label: "Summary",
              onPress: () => Navigation().navigation(context, const Summary()),
              background: primary,
              foreground: text,
              height: 160,
              font: largeFont,
            )
          ],
        ),
      ),
    );
  }
}
