import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/webScraping.dart';
import 'package:khulasa/Models/link.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/constants/api.dart';
import 'package:khulasa/constants/sources.dart';

import 'package:provider/provider.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  String text = "No Text";
  List<Link> links = [];

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
                // List<String> links = [];

                //testing mode switch
                context.read<DarkMode>().toggleMode();

                //uncomment to test rss code

                /*
                for (var element in sources) {
                  var l = await WebScraping().getLinksFromLink(element);
                  print(l);
                  links.addAll(l);
                }
                if (links.isNotEmpty) {
                  var a = await WebScraping().getArticleFromLink(
                      source: links[0].source.source, link: links[0].link);
                  print(a);
                }
                setState(() {});
                */
              },
              child: const Text("Toggle Mode"),
            ),
            if (links.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: links.length,
                  itemBuilder: (context, index) =>
                      ListTile(title: Text(links[index].link)),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
