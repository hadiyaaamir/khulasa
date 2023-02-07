import 'package:flutter/material.dart';
import 'package:khulasa/constants/colors.dart';

const List<Widget> options= <Widget>[
  Text('English'),
  Text('اردو', style: TextStyle(fontWeight: FontWeight.bold) ,),

];


class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool vertical = false;
  final List<bool> selected = <bool>[true, false];
  @override
  Widget build(BuildContext context) {
    return 
      ToggleButtons(
                direction: vertical ? Axis.vertical : Axis.horizontal,
                onPressed: (int index) {
                  setState(() {
                    // The button that is tapped is set to true, and the others to false.
                    for (int i = 0; i < selected.length; i++) {
                      selected[i] = i == index;
                    }
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderWidth: 3,
                selectedBorderColor: darkBlue,
                selectedColor: Colors.white,
                fillColor: darkBlue,
                color: darkBlue,
                constraints: const BoxConstraints(
                  minHeight: 30.0,
                  minWidth: 040.0,
                ),
                isSelected: selected,
                children: options,
              
    );
  }
}

