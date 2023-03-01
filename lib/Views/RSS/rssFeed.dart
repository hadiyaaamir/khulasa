import 'package:flutter/material.dart';

import 'package:khulasa/Controllers/RSS/articleprovider.dart';
import 'package:khulasa/Controllers/dateFormat.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/article.dart';
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

    artList.isEmpty ? isLoading = true : isLoading = false;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text("RSS Feed"),
        centerTitle: true,
        backgroundColor: background,
      ),
      drawer: const Drawer(
        child: Draw(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? const CircularProgressIndicator(color: primary)
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 30),
                      itemCount: artList.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          color: primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 30),
                            title: Text(
                              artList[index].title,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: secondary,
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
                                  speakText: artList[index].summary,
                                ),
                                Text(
                                  artList[index].summary,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: text,
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
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          const Divider(color: background, thickness: 1.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpeakIconButton(
                speakText: speakText,
                vertPadding: 0,
                iconColor: background,
              ),
              Text('$source | $date', style: const TextStyle(color: text2)),
            ],
          ),
          const Divider(color: background, thickness: 1.2),
        ],
      ),
    );
  }
}
