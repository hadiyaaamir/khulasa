import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Controllers/webScraping.dart';
import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/constants/api.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  String text = "No Text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            ElevatedButton(
                onPressed: () async {
                  var links = await WebScraping()
                      .getLinksFromLink("https://urdu.arynews.tv/");
                  print(links);
                },
                child: Text("Call API"))
          ],
        ),
      ),
    );
  }
}
