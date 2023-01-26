import 'package:flutter/cupertino.dart';

class ApiObject {
  String name;

  ApiObject({
    required this.name,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    return data;
  }

  static ApiObject fromJson(Map<String, dynamic> json) {
    return ApiObject(
      name: json['name'],
    );
  }
}
