import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Controllers/webScraping.dart';
import 'package:khulasa/Models/link.dart';
import 'package:khulasa/Models/source.dart';
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
                  List<String> links = [];
                  List<Source> sources = WebScraping().sources;
                  for (var element in sources) {
                    var l = await WebScraping()
                        .getLinksFromLink(element.webLink, element);
                    // links.addAll(Link(link: l, source: element));
                  }
                  print(links);
                },
                child: Text("Call API"))
          ],
        ),
      ),
    );
  }
}
