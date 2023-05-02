import 'package:flutter/material.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:provider/provider.dart';

class textField extends StatefulWidget {
  textField({
    super.key,
    required this.label,
    required this.controller,
    this.validate,
    this.password = false,
    this.icon,
    this.lines = 1,
    this.paddingVert = 10,
    this.paddingHor = 40,
    this.textAlign = TextAlign.left,
    this.allowEmpty = false,
    this.isLoading = false,
    this.isEnabled = true,
  });

  final TextEditingController controller;
  final String label;
  final Function(String?)? validate;
  final bool password;
  final IconData? icon;
  final int lines;
  final double paddingVert;
  final double paddingHor;
  final TextAlign textAlign;

  final bool allowEmpty;
  final bool isLoading;
  final bool isEnabled;

  @override
  State<textField> createState() => _textFieldState();
}

class _textFieldState extends State<textField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.paddingHor, vertical: widget.paddingVert),
      child: TextFormField(
        textAlign: widget.textAlign,
        cursorColor: colors.text,
        enabled: widget.isEnabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.password && !showPassword,
        controller: widget.controller,
        keyboardType:
            widget.lines > 1 ? TextInputType.multiline : TextInputType.text,
        minLines: widget.lines,
        maxLines: widget.lines,
        decoration: InputDecoration(
          suffix: widget.isLoading ? const CircularProgressIndicator() : null,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            borderRadius: BorderRadius.circular(5),
          ),
          filled: true,
          fillColor: colors.primary,
          // icon: Icon(icon, color: text),
          labelText: widget.label,
          labelStyle: TextStyle(color: colors.text),
          suffixIcon: widget.password
              ? IconButton(
                  onPressed: () => setState(() => showPassword = !showPassword),
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: colors.secondary,
                  ),
                )
              : null,
        ),
        onSaved: (String? value) {
          // This optional block of code can be used to run
          // code when the user saves the form.
        },
        validator: (value) {
          if (!widget.allowEmpty && value != null && value.isEmpty) {
            return "Field cannot be empty";
          }
          return widget.validate == null ? null : widget.validate!(value);
        },
        style: (TextStyle(color: colors.text)),
      ),
    );
  }
}
