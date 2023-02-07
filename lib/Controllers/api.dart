import 'dart:convert';

import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/constants/api.dart';
import 'package:http/http.dart' as http;

class Api {
  //get summary
  // generateSummary({

  // }) {

  // }

  Future<Summary> generateSummary({
    required String algo,
    required String text,
    required double ratio,
  }) async {
    var url = Uri.parse("${apiUrl}/api");
    final headers = {'Content-Type': 'application/json'};
    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(<String, dynamic>{
        'text': text,
        'algo': algo,
        'ratio': ratio,
      }),
    );

    final parsed = json.decode(response.body);
    Summary s = Summary.fromJson(parsed as Map<String, dynamic>);
    return s;
    // return
  }
}
