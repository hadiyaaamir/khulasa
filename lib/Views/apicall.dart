import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:khulasa/Models/apiObject.dart';
import 'package:khulasa/constants/url.dart';

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  String text = "No Text";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
            ElevatedButton(
                onPressed: () async {
                  text = await fetchData();
                  setState(() {});
                },
                child: Text("Call API"))
          ],
        ),
      ),
    );
  }

  Future<String> fetchData() async {
    var url = Uri.parse("$apiUrl/api?name=faiza");
    var response = await http.get(url);

    final parsed = jsonDecode(response.body);
    ApiObject a = ApiObject.fromJson(parsed as Map<String, dynamic>);
    return a.name;
    // return
  }
}
