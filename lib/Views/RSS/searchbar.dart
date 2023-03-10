import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  SearchBar({
    super.key,
    required this.setArtList,
    required this.allArtList,
    required this.setItemCount,
  });

  final Function(List) setArtList;
  final List allArtList;
  final Function(int) setItemCount;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // List allArtList;
  TextEditingController _searchController = TextEditingController();
  List artList = [];
  int itemcount = 0;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    if (_searchController.text.isEmpty) {
      widget.setArtList(widget.allArtList);
      widget.setItemCount(widget.allArtList.length);
    } else {
      widget.setArtList(artList);
      widget.setItemCount(itemcount);
      print(itemcount);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          print(value);
          final suggestions = widget.allArtList.where((art) {
            return art.title.contains(value.toString()) ||
                art.content.contains(value.toString());
          }).toList();

          setState(() {
            artList = suggestions;
            itemcount = suggestions.length;
          });
        },

        //styles
        style: TextStyle(color: colors.text),

        //inner styles
        decoration: InputDecoration(
          hintText: "Search Feed",
          hintStyle: TextStyle(color: colors.text2),
          prefixIcon: Icon(Icons.search, color: colors.secondary),
          filled: true,
          fillColor: colors.primary,

          //borders
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: colors.secondary),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: colors.text2),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
