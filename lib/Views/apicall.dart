// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khulasa/Controllers/Backend/api.dart';
import 'package:khulasa/Controllers/Backend/categoryExcel.dart';
import 'package:khulasa/Controllers/Backend/dateFormat.dart';
import 'package:khulasa/Controllers/Config/darkMode.dart';
import 'package:khulasa/Controllers/Backend/webScraping.dart';
import 'package:khulasa/Controllers/articleprovider.dart';
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
  List articles = [];

  List<NewsSource> formatSources = [];
  List<String> formatSourceLinks = [];
  List formattedDates = [];

  String article = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //get category excel
            ElevatedButton(
              onPressed: () {
                //testing mode switch
                CategoryExcel()
                    .toExcel(context.read<articleprovider>().articlesList);
              },
              child: Text('Get Categories Excel'),
            ),

            //test web scraping stuff
            ElevatedButton(
              onPressed: () async {
                // links = [];

                //format dates
                // formatSourceLinks = [
                //   'https://www.dawnnews.tv/news/1199504/',
                //   'https://jang.com.pk/news/1207430',
                //   'https://www.express.pk/story/2459071/10/',
                //   'https://www.nawaiwaqt.com.pk/25-Mar-2023/1695681',
                // ];

                // formatSources = [
                //   sources[0],
                //   sources[1],
                //   sources[2],
                //   sources[3],
                // ];

                // formattedDates = ['', '', '', ''];

                // setState(() {});

                // for (var i = 0; i < formatSources.length; i++) {
                //   final response = await http.Client().get(
                //       Uri.parse(formatSourceLinks[i]),
                //       headers: {'User-Agent': 'Mozilla/5.0'});

                //   if (response.statusCode == 200) {
                //     var document = parser.parse(response.body);
                //     String date = "";

                //     if (formatSources[i].dateTagType == 'class') {
                //       date = document
                //           .getElementsByClassName(formatSources[i].dateTag)[
                //               formatSources[i].dateIndex]
                //           .text;
                //     }

                //     //get by attribute
                //     else if (formatSources[i].dateTagType == 'attribute-tag') {
                //       date = document
                //               .getElementsByTagName(formatSources[i].dateTag)[
                //                   formatSources[i].dateIndex]
                //               .attributes[formatSources[i].attributeName] ??
                //           "";
                //     }

                //     //get by attribute inside class
                //     else if (formatSources[i].dateTagType ==
                //         'attribute-class') {
                //       date = document
                //               .getElementsByClassName(formatSources[i].dateTag)[
                //                   formatSources[i].dateIndex]
                //               .attributes[formatSources[i].attributeName] ??
                //           "";
                //     }

                //     formattedDates[i] = DateFormatter().toDateTime(date, false);
                //     setState(() {});
                //   }
                // }

                // }

                //web scraping
                String link =
                    'https://www.nawaiwaqt.com.pk/25-Mar-2023/1695681';
                final response = await http.Client().get(Uri.parse(link),
                    headers: {'User-Agent': 'Mozilla/5.0'});
                if (response.statusCode == 200) {
                  var document = parser.parse(response.body);

                  int index = sources.indexWhere((element) =>
                      element.source == NewsSource.getSourceFromLink(link));

                  String title =
                      index != -1 ? sources[index].getTitle(document) : "";

                  String content =
                      //       // sources[index].getArticle(document)
                      index != -1 ? sources[index].getArticle(document) : "";

                  // var date = document
                  //     .getElementsByClassName(sources[index].dateTag)[0]
                  //     .text;

                  //date formatter code
                  // var d = DateFormatter().toDateTime(date, false);

                  // var date = index != -1
                  //     ? sources[index].getDate(document)
                  //     : DateTime(2001);
                  article = '${index == -1 ? -1 : sources[index]}';
                  setState(() {});
                } else {
                  article = '${response.statusCode}';
                  setState(() {});
                }

                //  rss feed
                // for (var element in sources) {
                // var l = await WebScraping().getLinksFromLink(sources[5]);
                // print(l);
                // links.addAll(l);
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

            //display list of dates to format
            if (formatSourceLinks.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: formatSourceLinks.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(formatSources[index].source),
                    subtitle: Text(formattedDates[index].toString()),
                  ),
                ),
              ),
            ],

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
