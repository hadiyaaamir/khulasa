import 'package:flutter/material.dart';
import 'package:khulasa/constants/colors.dart';

class textField extends StatelessWidget {
  const textField({
    super.key,
    required this.label,
    required this.controller,
    required this.validate,
    this.password = false,
    this.icon,
  });

  final TextEditingController controller;
  final String label;
  final Function(String?) validate;
  final bool password;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: TextFormField(
          cursorColor: text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: password,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              borderRadius: BorderRadius.circular(5),
            ),
            filled: true,
            fillColor: primary,
            // icon: Icon(icon, color: text),
            labelText: label,
            labelStyle: const TextStyle(color: text),
          ),
          onSaved: (String? value) {
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (value) {
            if (value != null && value.isEmpty) {
              return "Field cannot be empty";
            }
            return validate(value);
          },
          style: (const TextStyle(
            color: text,
          )),
        ));
  }
}
