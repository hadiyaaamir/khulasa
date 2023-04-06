import 'package:flutter/material.dart';

class Navigation {
  //normal navigation
  navigation(BuildContext context, Widget route) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );
  }

  //nav replacement
  navigationReplace(BuildContext context, Widget route) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ),
    );
  }

  //pop
  navigationPop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
