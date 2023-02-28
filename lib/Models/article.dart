import 'dart:io';

import 'package:khulasa/Models/link.dart';

class article {
  String title;
  String summary;
  String content;
  String category;
  Link? link;

  article({
    required this.title,
    required this.summary,
    required this.content,
    this.category = "",
    this.link,
  });

  String toString() {
    return content;
  }
}
