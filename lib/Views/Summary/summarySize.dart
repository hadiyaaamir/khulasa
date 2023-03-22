import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:provider/provider.dart';
import 'package:khulasa/constants/sizes.dart';

class SummarySize extends StatefulWidget {
  SummarySize({super.key, this.setSize});

  final Function(String)? setSize;

  @override
  State<SummarySize> createState() => _SummarySizeState();
}

class _SummarySizeState extends State<SummarySize> {
  String size = "Short";

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;

    if (widget.setSize != null) widget.setSize!(size);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: colors.primary, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'Summary Size',
                  style: TextStyle(color: colors.text, fontSize: buttonFont),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Radio(
                    value: "Short",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() => size = value.toString());
                    },
                    fillColor: MaterialStateProperty.all<Color>(colors.text2),
                  ),
                  Text("Short", style: TextStyle(color: colors.text2))
                ]),
                Row(children: [
                  Radio(
                    value: "Medium",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() => size = value.toString());
                    },
                    fillColor: MaterialStateProperty.all<Color>(colors.text2),
                  ),
                  Text("Medium", style: TextStyle(color: colors.text2))
                ]),
                Row(
                  children: [
                    Radio(
                      value: "Long",
                      groupValue: size,
                      onChanged: (value) {
                        setState(() => size = value.toString());
                      },
                      fillColor: MaterialStateProperty.all<Color>(colors.text2),
                    ),
                    Text("Long", style: TextStyle(color: colors.text2))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
