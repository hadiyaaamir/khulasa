import 'dart:convert';

import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/constants/api.dart';
import 'package:http/http.dart' as http;

class Api {
  //get summary
  // generateSummary({

  // }) {

  // }

  Future<String> generateSummary({
    required String algo,
    required String text,
    required double ratio,
  }) async {
    var url = Uri.parse("$apiUrl/api?name=faiza");
    var response = await http.get(url);

    final parsed = jsonDecode(response.body);
    ApiObject a = ApiObject.fromJson(parsed as Map<String, dynamic>);
    return a.name;
    // return
  }
}
