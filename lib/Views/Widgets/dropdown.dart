import 'package:flutter/material.dart';
import 'package:khulasa/constants/colors.dart';
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
    List<String> categories = widget.categories;

    Object? _category;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 50, vertical: widget.paddingVert),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: primary,
        ),
        child: DropdownButtonFormField(
          dropdownColor: primary,
          icon: const Icon(Icons.keyboard_arrow_down, color: text),
          items: categories.map((String category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category, style: const TextStyle(color: text)),
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
            hintStyle: const TextStyle(color: text),
            focusedBorder:
                const UnderlineInputBorder(borderSide: BorderSide.none),
            border: const UnderlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
