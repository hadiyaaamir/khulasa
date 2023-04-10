import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/RSS/Filter/filterOptions.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  const Filter({
    super.key,
    required this.filteredSources,
    required this.setFilteredSources,
  });

  final List filteredSources;
  final Function(List) setFilteredSources;

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Container(
        decoration: BoxDecoration(
          color: colors.secondary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 3, color: colors.primary, spreadRadius: 3)
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.filter_list, color: white),
          onPressed: () async {
            // showFilterPopup(context);

            bool? modal = await showModalBottomSheet(
              context: context,
              backgroundColor: colors.primary,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
              ),
              builder: (BuildContext context) => FilterOptionsBox(
                filteredSources: widget.filteredSources,
                setFilteredSources: widget.setFilteredSources,
              ),
              isScrollControlled: true,
              // constraints: BoxConstraints(maxHeight: screenHeight * 2 / 3),
            );
          },
        ),
      ),
    );
  }
}
