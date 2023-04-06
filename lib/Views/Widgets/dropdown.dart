import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class Dropdown extends StatefulWidget {
  const Dropdown({
    Key? key,
    this.validate,
    required this.label,
    required this.categories,
    this.paddingVert = 10,
    this.setAlgo,
  }) : super(key: key);

  final Function(String?)? validate;
  final String label;
  final List<String> categories;
  final double paddingVert;
  final Function(String)? setAlgo;

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   user.gender = "";
  // }

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    List<String> categories = widget.categories;

    Object? _category;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 40, vertical: widget.paddingVert),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colors.primary,
        ),
        child: DropdownButtonFormField(
          dropdownColor: colors.primary,
          icon: Icon(Icons.keyboard_arrow_down, color: colors.text),
          items: categories.map((String category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category, style: TextStyle(color: colors.text)),
            );
          }).toList(),
          onChanged: (newValue) {
            // user.gender = newValue.toString();
            if (widget.setAlgo != null) widget.setAlgo!(newValue.toString());
            setState(() {
              _category = newValue;
            });
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (text) {
            if (text == null) {
              return 'Please select an item';
            }
            return null;
          },
          value: _category,
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: TextStyle(color: colors.text),
            focusedBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
