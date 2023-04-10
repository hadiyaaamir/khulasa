import 'package:flutter/material.dart';
import 'package:khulasa/Views/Widgets/labelIcon.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LabelIcon(
      icon: Icons.save,
      label: "Save",
      onPress: () {},
    );
  }
}
