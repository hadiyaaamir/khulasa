import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

import '../../Controllers/RSS/articleprovider.dart';

class Article extends StatefulWidget {
  final int i;
  const Article({Key? key, required this.i}) : super(key: key);

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    List<article> articlelist =
        context.watch<articleprovider>().getarticleList();
    return Scaffold(
        backgroundColor: background,
        body: Center(
            child: Column(
          children: [
            Text(articlelist[widget.i].title,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    color: text,
                    fontWeight: FontWeight.bold,
                    fontSize: headingFont)),
            Card(
                color: background,
                child: Text(articlelist[widget.i].content,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: text, fontSize: smallFont))),
          ],
        )));
  }
}
