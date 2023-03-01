import 'dart:io';

import 'package:khulasa/Models/link.dart';

class article {
  String title;
  String summary;
  String content;
  String category;
  Link? link;
  DateTime date;
  // String date;

  article({
    required this.title,
    required this.summary,
    required this.content,
    this.category = "",
    this.link,
    required this.date,
  });

  String toString() {
    return content;
  }
}
