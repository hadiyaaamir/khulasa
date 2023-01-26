import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khulasa/Views/apicall.dart';
import 'package:khulasa/constants/colors.dart';
import 'package:khulasa/constants/fonts.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // textTheme: GoogleFonts.notoNastaliqUrduTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() async {
    // bool result = await InternetConnectionChecker().hasConnection;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ApiCall()),
    );
  }

  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Blue,
      body: Center(
          child: (Text("خلاصہ",
              style: TextStyle(color: Colors.white, fontSize: large_font)))),
    );
  }
}
