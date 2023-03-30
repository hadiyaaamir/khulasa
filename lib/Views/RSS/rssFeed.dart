import 'package:flutter/material.dart';

import 'package:khulasa/Controllers/RSS/articleprovider.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/dateFormat.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/RSS/article.dart';
import 'package:khulasa/Views/RSS/filter.dart';
import 'package:khulasa/Views/RSS/searchbar.dart';
import 'package:khulasa/Views/Widgets/iconButtons.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class RssFeed extends StatefulWidget {
  const RssFeed({super.key});

  @override
  State<RssFeed> createState() => _RssFeedState();
}

class _RssFeedState extends State<RssFeed> {
  bool isLoading = true;
  List? artList;
  int? count;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   artList = [];
  //   count = artList.length;
  // }

  @override
  Widget build(BuildContext context) {
    List allArtList = context.watch<articleprovider>().articlesList;
    bool isFinished = context.watch<articleprovider>().isFinished;
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    allArtList.isEmpty ? isLoading = true : isLoading = false;

    // if(artList == null)

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text(
          "RSS Feed",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colors.background,
        foregroundColor: isDarkMode ? colors.text : colors.secondary,
        elevation: 0,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         context.read<articleprovider>().getArticles();
        //       },
        //       icon: Icon(Icons.refresh))
        // ],
      ),
      drawer: const Drawer(
        child: Draw(),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //search and filter
            Row(
              children: [
                Filter(),
                SearchBar(
                  setArtList: (List list) => artList = list,
                  setItemCount: (int itemcount) => count = itemcount,
                  allArtList: allArtList,
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(
                'Fetched ${count.toString()} articles',
                style: TextStyle(color: colors.text),
              ),
            ),

            //articles list
            Expanded(
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: colors.primary),
                      ],
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 30, right: 30, top: 5),
                      itemCount: count ?? allArtList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Card(
                              color: colors.primary,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 30),
                                title: Text(
                                  artList == null
                                      ? allArtList[index].title
                                      : artList![index].title,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: colors.text,
                                    fontWeight: FontWeight.w900,
                                    fontSize: headingFont,
                                  ),
                                ),
                                subtitle: Column(
                                  children: [
                                    SourceLine(
                                      source: artList == null
                                          ? allArtList[index].link.source.source
                                          : artList![index].link.source.source,
                                      date: DateFormatter().formatDate(
                                          artList == null
                                              ? allArtList[index].date
                                              : artList![index].date),
                                      speakText: artList == null
                                          ? "${allArtList[index].title}.${allArtList[index].summary}"
                                          : "${artList![index].title}.${artList![index].summary}",
                                    ),
                                    Text(
                                      artList == null
                                          ? allArtList[index].summary
                                          : artList![index].summary,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: colors.text,
                                        fontSize: buttonFont,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigation().navigation(
                                      context,
                                      Article(
                                          art: artList == null
                                              ? allArtList[index]
                                              : artList![index]));
                                },
                              ),
                            ),
                            // if (!isFinished &&
                            //     index == (count ?? allArtList.length) - 1) ...[
                            //   Padding(
                            //     padding: const EdgeInsets.only(top: 20),
                            //     child: SizedBox(
                            //       width: 25,
                            //       height: 25,
                            //       child: CircularProgressIndicator(
                            //         color: colors.primary,
                            //       ),
                            //     ),
                            //   )
                            // ],
                          ],
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class SourceLine extends StatelessWidget {
  const SourceLine({
    super.key,
    required this.source,
    required this.date,
    required this.speakText,
  });

  final String source;
  final String date;
  final String speakText;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    bool isDarkMode = context.watch<DarkMode>().isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          Divider(
              color: isDarkMode ? colors.background : colors.secondary,
              thickness: 1.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpeakIconButton(
                speakText: speakText,
                vertPadding: 0,
                iconColor: isDarkMode ? colors.text : colors.secondary,
              ),
              Text('$source | $date', style: TextStyle(color: colors.text2)),
            ],
          ),
          Divider(
              color: isDarkMode ? colors.background : colors.secondary,
              thickness: 1.2),
        ],
      ),
    );
  }
}
