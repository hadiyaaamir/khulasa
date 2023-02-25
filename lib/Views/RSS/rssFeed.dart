import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulasa/Controllers/RSS/articleprovider.dart';
import 'package:khulasa/Controllers/navigation.dart';
import 'package:khulasa/Models/article.dart';
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
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Card(
                    color: primary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(25),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          artList[index].title,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.notoNastaliqUrdu(
                            color: secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonFont,
                          ),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          // if (artList[index].link != null) ...[
                          //   Text(artList[index].link.link),
                          //   Text(artList[index].link.source.source)
                          // ],
                          Text(
                            artList[index].summary,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.notoNastaliqUrdu(
                              color: text,
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
