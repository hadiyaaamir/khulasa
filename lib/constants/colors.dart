import 'package:flutter/material.dart';
import 'package:khulasa/Models/colorTheme.dart';

const Color blue = Color(0xff0C2A36);
const Color lightBlue = Color(0xff466471);
const Color darkBlue = Color(0xff00070B);
const Color grey = Color(0xffA9AEB0);
const Color red = Color(0xffA46666);

const Color white = Color.fromRGBO(255, 255, 255, 1);

//light theme specific palette
const Color veryLightBlue = Color(0xffe1eef2);
const Color thoraBlue = Color(0xff3a7690);
const Color darkGrey = Color(0xff2f2e2e);
const Color kumDarkBlue = Color(0xff123f53);
const Color lightGrey = Color(0xff565454);
const Color bohatLightGrey = Color(0xfff5f7f7);
//button color

//orange

const Color darkOrange = Color(0xffb13622);
const Color lightDarkOrange = Color(0xffab6e63);

const Color lightOrange = Color(0xffecc8c2);
const Color darkLightOrange = Color(0xffdf6e5b);

const Color veryDarkOrange = Color(0xff390b04);

//green
const Color darkGreen = Color(0xff059f95);
const Color lightDarkGreen = Color(0xff045958);

const Color lightGreen = Color(0xff209d95);
const Color darkLightGreen = Color(0xffc1e3e1);

const Color veryDarkGreen = Color(0xff02413d);

//neutral
const Color darkBrown = Color(0xff661f1f);
const Color lightDarkBrown = Color(0xff714242);

const Color lightBrown = Color(0xffa46666);
const Color darkLightBrown = Color(0xffd1b2b2);

const Color veryDarkBrown = Color(0xff390101);

// --------- colour themes --------- \\

//GREEN
ColorTheme greenDarkMode = ColorTheme(
  background: darkBlue,
  primary: lightDarkGreen,
  secondary: darkGreen,
  text: white,
  text2: grey,
  caution: red,
);

final ColorTheme greenLightMode = ColorTheme(
  background: white,
  primary: darkLightGreen,
  secondary: lightGreen,
  text: veryDarkGreen,
  text2: lightGrey,
  caution: red,
);

//BLUE
ColorTheme blueDarkMode = ColorTheme(
  background: darkBlue,
  primary: lightBlue,
  secondary: blue,
  text: white,
  text2: grey,
  caution: red,
);

ColorTheme blueLightMode = ColorTheme(
  background: white,
  primary: veryLightBlue,
  secondary: thoraBlue,
  text: kumDarkBlue,
  text2: lightGrey,
  caution: red,
);

//ORANGE
ColorTheme orangeDarkMode = ColorTheme(
  background: darkBlue,
  primary: lightDarkOrange,
  secondary: darkOrange,
  text: white,
  text2: grey,
  caution: red,
);

ColorTheme orangeLightMode = ColorTheme(
  background: white,
  primary: lightOrange,
  secondary: darkLightOrange,
  text: veryDarkOrange,
  text2: lightGrey,
  caution: red,
);

//NEUTRAL
ColorTheme neutralDarkMode = ColorTheme(
  background: darkBlue,
  primary: lightDarkBrown,
  secondary: darkBrown,
  text: white,
  text2: grey,
  caution: red,
);

ColorTheme neutralLightMode = ColorTheme(
  background: white,
  primary: darkLightBrown,
  secondary: lightBrown,
  text: veryDarkBrown,
  text2: lightGrey,
  caution: red,
);
