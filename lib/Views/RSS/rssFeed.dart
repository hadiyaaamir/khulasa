import 'package:flutter/material.dart';

import 'package:khulasa/Controllers/RSS/articleprovider.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Controllers/dateFormat.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/RSS/article.dart';
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

  @override
  Widget build(BuildContext context) {
    List artList = context.watch<articleprovider>().articlesList;
    ColorTheme colors = context.watch<DarkMode>().mode;

    artList.isEmpty ? isLoading = true : isLoading = false;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text("RSS Feed"),
        centerTitle: true,
        backgroundColor: colors.background,
        actions: [
          IconButton(
              onPressed: () {
                context.read<articleprovider>().getArticles();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      drawer: const Drawer(
        child: Draw(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? CircularProgressIndicator(color: colors.primary)
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      itemCount: artList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          color: colors.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 30),
                            title: Text(
                              artList[index].title,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: colors.secondary,
                                fontWeight: FontWeight.w900,
                                fontSize: headingFont,
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                SourceLine(
                                  source: artList[index].link.source.source,
                                  date: DateFormat()
                                      .formatDate(artList[index].date),
                                  speakText:
                                      "${artList[index].title}.${artList[index].summary}",
                                ),
                                Text(
                                  artList[index].summary,
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
                                  context, Article(art: artList[index]));
                            },
                          ),
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

    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          Divider(color: colors.background, thickness: 1.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpeakIconButton(
                speakText: speakText,
                vertPadding: 0,
                iconColor: colors.background,
              ),
              Text('$source | $date', style: TextStyle(color: colors.text2)),
            ],
          ),
          Divider(color: colors.background, thickness: 1.2),
        ],
      ),
    );
  }
}
