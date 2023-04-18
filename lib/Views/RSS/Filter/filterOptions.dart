import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Config/languageprovider.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/Views/RSS/Filter/sourceFilter.dart';
import 'package:khulasa/Views/Widgets/button.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:khulasa/constants/sources.dart';
import 'package:provider/provider.dart';

class FilterOptionsBox extends StatefulWidget {
  const FilterOptionsBox({
    super.key,
    required this.filteredSources,
    required this.setFilteredSources,
  });

  final List filteredSources;
  final Function(List) setFilteredSources;

  @override
  State<FilterOptionsBox> createState() => _FilterOptionsBoxState();
}

class _FilterOptionsBoxState extends State<FilterOptionsBox> {
  late List checkedSources;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkedSources = List.from(widget.filteredSources);
  }

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isEnglish = context.watch<Language>().isEnglish;

    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //heading
            Text(
              isEnglish ? 'Filter Feed' : 'مقطر کریں',
              style: TextStyle(
                  color: colors.text,
                  fontSize: isEnglish ? headingFont : headingFont + 4,
                  fontWeight: FontWeight.w600),
            ),

            // Divider
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Divider(color: colors.background),
            ),

            //News sources filter
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: SourceFilter(
                checkedSources: checkedSources,
                addSource: (NewsSource s) =>
                    setState(() => checkedSources.add(s)),
                removeSource: (NewsSource s) =>
                    setState(() => checkedSources.remove(s)),
              ),
            ),

            // Divider
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Divider(color: colors.background),
            ),

            //Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Btn(
                  label: isEnglish ? 'Clear' : 'مٹا دیں',
                  onPress: () {
                    checkedSources = List.from(sources);
                    setState(() {});
                  },
                  width: 100,
                  paddingHor: 0,
                  background: colors.primary,
                  foreground: colors.text,
                  fontWeight: FontWeight.w600,
                  paddingVert: 5,
                  borderColor: colors.secondary,
                ),
                Btn(
                  label: isEnglish ? 'Apply Filters' : 'مقطر کریں',
                  onPress: () {
                    widget.setFilteredSources(checkedSources);
                    Navigator.pop(context, true);
                  },
                  width: 200,
                  paddingHor: 0,
                  foreground:
                      colors == blueDarkMode ? colors.text : colors.background,
                  fontWeight: FontWeight.w600,
                  paddingVert: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
