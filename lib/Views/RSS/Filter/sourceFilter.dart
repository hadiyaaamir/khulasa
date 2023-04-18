import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/Views/RSS/Filter/sourceCheckbox.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:khulasa/constants/sources.dart';
import 'package:provider/provider.dart';

class SourceFilter extends StatefulWidget {
  const SourceFilter({
    super.key,
    required this.addSource,
    required this.removeSource,
    required this.checkedSources,
  });

  final Function(NewsSource) addSource;
  final Function(NewsSource) removeSource;
  final List checkedSources;

  @override
  State<SourceFilter> createState() => _SourceFilterState();
}

class _SourceFilterState extends State<SourceFilter> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    List checkedSources = widget.checkedSources;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5, left: 5, bottom: 15),
          child: Text(
            isEnglish ? 'News Sources' : 'اخبار کے ذرائع',
            style: TextStyle(
                color: colors.text,
                fontSize: isEnglish ? buttonFont : buttonFont + 2),
          ),
        ),
        Wrap(
          children: List.generate(
            sources.length,
            (index) => SourceCheckbox(
              source: sources[index],
              addSource: (NewsSource s) => setState(() => widget.addSource(s)),
              removeSource: (NewsSource s) =>
                  setState(() => widget.removeSource(s)),
              isChecked: checkedSources.contains(sources[index]),
            ),
          ),
        ),
      ],
    );
  }
}
