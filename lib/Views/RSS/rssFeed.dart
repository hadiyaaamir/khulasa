import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:khulasa/Controllers/RSS/articleprovider.dart';
import 'package:khulasa/Models/article.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Text(
                'RSS Feed',
                style: TextStyle(
                  color: text,
                  fontSize: headingFont,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                itemCount: artList.length,
                itemBuilder: (context, index) => Card(
                  color: primary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ListTile(
                    title: Text(
                      artList[index].title,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: headingFont),
                    ),
                    subtitle: Text(
                      artList[index].summary,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: text,
                      ),
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
