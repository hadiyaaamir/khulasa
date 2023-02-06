import 'package:flutter/cupertino.dart';

class Summary {
  String summary;

  Summary({
    required this.summary,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['summary'] = summary;
    return data;
  }

  static Summary fromJson(Map<String, dynamic> json) {
    return Summary(
      summary: json['name'],
    );
  }
}
