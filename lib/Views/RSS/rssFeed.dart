import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulasa/Controllers/RSS/articleprovider.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/source.dart';
import 'package:khulasa/Views/NavBar/AppBarPage.dart';
import 'package:khulasa/Views/RSS/article.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

class RssFeed extends StatefulWidget {
  const RssFeed({super.key});

  @override
  State<RssFeed> createState() => _RssFeedState();
}

class _RssFeedState extends State<RssFeed> {
  @override
  Widget build(BuildContext context) {
    List artList = context.watch<articleprovider>().articlesList;

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
            // const Padding(
            //   padding: EdgeInsets.only(top: 5.0),
            //   child: Text(
            //     'RSS Feed',
            //     style: TextStyle(
            //       color: text,
            //       fontSize: headingFont,
            //     ),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                          // if (artList[index].link != null) ...[
                          //   Text(artList[index].link.link),
                          //   Text(artList[index].link.source.source)
                          // ],
                          SourceLine(source: artList[index].link.source.source),
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
                        Navigation()
                            .navigation(context, Article(art: artList[index]));
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SourceLine extends StatelessWidget {
  const SourceLine({super.key, required this.source});

  final String source;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        children: [
          const Divider(color: background, thickness: 1.2),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,

              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(source, style: const TextStyle(color: text2)),
                const Text(' | 12/02/2022', style: TextStyle(color: text2)),
              ],
            ),
          ),
          const Divider(color: background, thickness: 1.2),
        ],
      ),
    );
  }
}
