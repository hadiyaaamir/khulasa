import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    key,
    this.background,
    this.foreground,
    this.title = "",
    this.fakeRTL = false,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final Size preferredSize;

  final String title;
  final Color? background;
  final Color? foreground;
  final bool fakeRTL;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    Color background = widget.background ?? colors.background;
    Color foreground =
        widget.foreground ?? (isDarkMode ? colors.text : colors.secondary);

    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: background,
      foregroundColor: foreground,
      elevation: 0,
      automaticallyImplyLeading: !widget.fakeRTL,
      actions: [
        if (widget.fakeRTL) ...[
          IconButton(
            onPressed: () => Navigation().navigationPop(context),
            icon: const Icon(Icons.arrow_forward),
          )
        ]
      ],
    );
  }
}
