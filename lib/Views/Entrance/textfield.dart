import 'package:flutter/material.dart';
import 'package:khulasa/constants/colors.dart';

class textField extends StatelessWidget {
  const textField({super.key, required this.label, required this.controller});
  final TextEditingController controller;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 5),
        child: TextFormField(
          cursorColor: text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(5),
            ),
            filled: true,
            fillColor: primary,
            icon: const Icon(Icons.email, color: text),
            labelText: label,
            labelStyle: const TextStyle(color: text),
          ),
          onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (String? value) {
            return (value != null && value.contains('@'))
                ? 'Do not use the @ char.'
                : null;
          },
          style: (const TextStyle(
            color: text,
          )),
        ));
  }
}
