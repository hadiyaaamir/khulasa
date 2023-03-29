import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/constants/sizes.dart';
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
      padding: const EdgeInsets.fromLTRB(10, 20, 30, 20),
      child: Container(
        constraints: BoxConstraints(maxWidth: 2 * screenWidth / 3),
        child: TextField(
          controller: _searchController,
          textAlign: TextAlign.right,
          onChanged: (value) {
            print(value);
            final suggestions = widget.allArtList.where((art) {
              return art.title
                      .toString()
                      .toLowerCase()
                      .contains(value.toString().toLowerCase()) ||
                  art.content
                      .toString()
                      .toLowerCase()
                      .contains(value.toString().toLowerCase()) ||
                  art.link.source.source
                      .toString()
                      .toLowerCase()
                      .contains(value.toString().toLowerCase());
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
            hintText: "تلاش کریں", //"Search Feed",
            hintStyle: TextStyle(color: colors.text2),
            suffixIcon: Icon(Icons.search, color: colors.secondary),
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
      ),
    );
  }
}
