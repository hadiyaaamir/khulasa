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
import 'package:html/parser.dart' as parser;

import 'package:provider/provider.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  String text = "No Text";
  List<Link> links = [];

  String article = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),

            //test toggling mode
            ElevatedButton(
              onPressed: () {
                //testing mode switch
                context.read<DarkMode>().toggleMode();
              },
              child: Text('Switch Mode'),
            ),

            //test web scraping stuff
            ElevatedButton(
              onPressed: () async {
                // links = [];

                final response = await http.Client().get(
                    Uri.parse('https://www.bbc.com/urdu/articles/cye4d894px3o'),
                    headers: {'User-Agent': 'Mozilla/5.0'});
                if (response.statusCode == 200) {
                  var document = parser.parse(response.body);

                  int index = sources
                      .indexWhere((element) => element.source == 'BBC Urdu');

                  String title =
                      index != -1 ? sources[index].getTitle(document) : "";

                  String content =
                      // sources[index].getArticle(document)
                      index != -1 ? sources[index].getArticle(document) : "";

                  // DateTime date = index != -1
                  //     ? sources[3].getDate(document)
                  //     : DateTime(2001);
                  article = content;
                  print(content);
                  setState(() {});
                }

                //  rss feed
                // for (var element in sources) {
                //   var l = await WebScraping().getLinksFromLink(element);
                //   print(l);
                //   links.addAll(l);
                // }
                // if (links.isNotEmpty) {
                //   var a = await WebScraping().getArticleFromLink(
                //       source: links[0].source.source, link: links[0].link);
                //   print(a);
                // }
                // setState(() {});
              },
              child: const Text("API Call"),
            ),

            //display article
            if (article != null) ...[
              SizedBox(
                height: article.isNotEmpty ? 500 : 0,
                child: SingleChildScrollView(
                  child: Text(article),
                ),
              ),
            ],

            //display links list
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
