import 'package:flutter/material.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';
import 'package:provider/provider.dart';

import '../../Controllers/RSS/articleprovider.dart';

class Article extends StatefulWidget {
  // final int i;
  const Article({Key? key, required this.art}) : super(key: key);

  final article art;

  @override
  State<Article> createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(widget.art.title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      color: text,
                      fontWeight: FontWeight.bold,
                      fontSize: headingFont)),
              Text(
                widget.art.content,
                textAlign: TextAlign.right,
                style: const TextStyle(color: text, fontSize: smallFont),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
