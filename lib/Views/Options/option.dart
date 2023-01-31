import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Views/Entrance/button.dart';
import 'package:khulasa/constants/colors.dart';

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
          child: Column(children: [
        Btn(
          label: "RSS Feed",
          onPress: () {},
          background: primary,
          foreground: background,
          height: 100,
        ),
        Btn(
          label: "Summary",
          onPress: () {},
          background: primary,
          foreground: background,
          height: 100,
        )
      ])),
    );
  }
}
