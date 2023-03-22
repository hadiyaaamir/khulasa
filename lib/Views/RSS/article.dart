import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulasa/Controllers/darkMode.dart';
import 'package:khulasa/Models/article.dart';
import 'package:khulasa/Models/colorTheme.dart';
import 'package:khulasa/Views/Widgets/iconButtons.dart';
import 'package:provider/provider.dart';
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
    ColorTheme colors = context.watch<DarkMode>().mode;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 50, right: 30, left: 30),
            child: Column(
              children: [
                //title
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    widget.art.title,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoNastaliqUrdu(
                        color: colors.text,
                        fontWeight: FontWeight.bold,
                        fontSize: headingFont),
                  ),
                ),

                //options
                OptionsLine(
                    speakText: "${widget.art.title}.${widget.art.content}"),

                //article
                Text(
                  widget.art.content,
                  textAlign: TextAlign.right,
                  style: TextStyle(color: colors.text, fontSize: buttonFont),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionsLine extends StatelessWidget {
  const OptionsLine({super.key, required this.speakText});

  final String speakText;

  @override
  Widget build(BuildContext context) {
    ColorTheme colors = context.watch<DarkMode>().mode;
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 25),
      child: Column(
        children: [
          // const Divider(color: secondary, thickness: 1.2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpeakIconButton(
                speakText: speakText,
                vertPadding: 0,
                iconSize: iconLarge,
                iconColor: colors.text2,
              ),
              Row(children: const [
                SaveButton(),
                SizedBox(width: 15),
                ShareButton(),
              ]),
            ],
          ),
          // const Divider(color: secondary, thickness: 1.2),
        ],
      ),
    );
  }
}
