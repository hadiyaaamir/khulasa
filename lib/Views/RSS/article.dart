import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/sizes.dart';

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
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 50, right: 30, left: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    widget.art.title,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoNastaliqUrdu(
                        color: text,
                        fontWeight: FontWeight.bold,
                        fontSize: headingFont),
                  ),
                ),
                Text(
                  widget.art.content,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: text, fontSize: buttonFont),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
