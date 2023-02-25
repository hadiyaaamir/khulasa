import 'package:flutter/material.dart';
import 'package:khulasa/constants/colors.dart';

class textField extends StatelessWidget {
  const textField({
    super.key,
    required this.label,
    required this.controller,
    this.validate,
    this.password = false,
    this.icon,
    this.lines = 1,
    this.paddingVert = 10,
    this.textAlign = TextAlign.left,
    this.isLoading = false,
  });

  final TextEditingController controller;
  final String label;
  final Function(String?)? validate;
  final bool password;
  final IconData? icon;
  final int lines;
  final double paddingVert;
  final TextAlign textAlign;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: paddingVert),
        child: TextFormField(
          textAlign: textAlign,
          cursorColor: text,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: password,
          controller: controller,
          keyboardType:
              lines > 1 ? TextInputType.multiline : TextInputType.text,
          minLines: lines,
          maxLines: lines,
          decoration: InputDecoration(
            suffix: isLoading ? const CircularProgressIndicator() : null,
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
            return validate == null ? null : validate!(value);
          },
          style: (const TextStyle(
            color: text,
          )),
        ));
  }
}
