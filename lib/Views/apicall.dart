import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khulasa/Controllers/api.dart';
import 'package:khulasa/Models/summary.dart';
import 'package:khulasa/constants/api.dart';

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
                  text = await Api().rssFeed();
                  setState(() {});
                },
                child: Text("Call API"))
          ],
        ),
      ),
    );
  }

  
}
