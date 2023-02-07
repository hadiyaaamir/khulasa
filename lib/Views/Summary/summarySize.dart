import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

class SummarySize extends StatefulWidget {
  SummarySize({super.key});

  @override
  State<SummarySize> createState() => _SummarySizeState();
}

class _SummarySizeState extends State<SummarySize> {
  String size = "Short";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  'Summary Size',
                  style: TextStyle(color: text, fontSize: buttonFont),
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
                    fillColor: MaterialStateProperty.all<Color>(text2),
                  ),
                  const Text("Short", style: TextStyle(color: text2))
                ]),
                Row(children: [
                  Radio(
                    value: "Medium",
                    groupValue: size,
                    onChanged: (value) {
                      setState(() => size = value.toString());
                    },
                    fillColor: MaterialStateProperty.all<Color>(text2),
                  ),
                  const Text("Medium", style: TextStyle(color: text2))
                ]),
                Row(
                  children: [
                    Radio(
                      value: "Long",
                      groupValue: size,
                      onChanged: (value) {
                        setState(() => size = value.toString());
                      },
                      fillColor: MaterialStateProperty.all<Color>(text2),
                    ),
                    const Text("Long", style: TextStyle(color: text2))
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
