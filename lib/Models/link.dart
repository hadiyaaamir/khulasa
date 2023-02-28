import 'package:khulasa/Models/source.dart';

class Link {
  String link;
  Source source;

  Link({
    required this.link,
    required this.source,
  });

  String toString() {
    return "{link: $link, source: ${source.source}}";
  }
}
