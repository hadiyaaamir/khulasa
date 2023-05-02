import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/HelperFunctions/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    key,
    this.background,
    this.foreground,
    this.title = "",
    this.fakeRTL = false,
    this.trailing,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final Size preferredSize;

  final String title;
  final Color? background;
  final Color? foreground;
  final bool fakeRTL;
  final Widget? trailing;
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
        ],
        if (widget.trailing != null) ...[
          widget.trailing!,
        ],
      ],
    );
  }
}
