import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/NavBar/customAppBar.dart';
import 'package:provider/provider.dart';

class Font extends StatefulWidget {
  const Font({super.key});

  @override
  State<Font> createState() => _FontState();
}

class _FontState extends State<Font> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: CustomAppBar(title: 'Font Settings'),
    );
  }
}
