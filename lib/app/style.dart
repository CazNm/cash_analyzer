import 'package:flutter/material.dart';
// Define multi-used style like colors or text styles
// maybe we can make another style file for app's theme selecting function

const Color mainPink = Color.fromRGBO(255, 200, 200, 1);
const Color mainGreen = Color.fromRGBO(209, 255, 237, 1);
const Color white = Colors.white;
const Color grey138 = Color.fromRGBO(138, 138, 138, 1.0);
const Color grey204 = Color.fromRGBO(204, 204, 204, 1.0);
const Color grey217 = Color.fromRGBO(217, 217, 217, 1.0);
const Color grey247 = Color.fromRGBO(247, 247, 247, 1.0);
const Color navyDark = Color.fromRGBO(10, 20, 36, 1.0);
const Color black = Color.fromRGBO(34, 34, 34, 1.0);
const Color black48 = Color.fromRGBO(48, 48, 48, 1.0);
const Color salmon = Color.fromRGBO(227, 119, 107, 1.0);
const Color lightBlue = Color.fromRGBO(180, 240, 255, 1.0);
const Map<String, Color> primaryColorList = {
  'salmon': salmon,
  'lightBlue': lightBlue,
};

// why not?
const double defaultTextSize = 12;
const FontWeight defaultfontWeight = FontWeight.normal;
TextStyle defaultText(Color color,
    {double size = defaultTextSize,
    FontWeight fontWeight = FontWeight.normal,
    double lineHeight = 1.0}) {
  return TextStyle(fontSize: size, fontWeight: fontWeight, color: color, height: lineHeight);
}

TextStyle whiteText(
    {double size = 12,
    FontWeight fontWeight = FontWeight.normal,
    double lineHeight = 1.0}) {
  return TextStyle(
      fontSize: size, fontWeight: fontWeight, color: white, height: lineHeight);
}

TextStyle grey138Text(
    {double size = 12, FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      // color: Color.fromRGBO(138, 138, 138, 1.0)
      color: grey138 // why not?
      );
}

TextStyle grey204Text(
    {double size = 12, FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: Color.fromRGBO(204, 204, 204, 1.0));
}

TextStyle grey217Text(
    {double size = 12, FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: Color.fromRGBO(204, 204, 204, 1.0));
}

TextStyle mainPinkText(
    {double size = 12,
    FontWeight fontWeight = FontWeight.normal,
    bool underLine = false}) {
  return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: mainPink,
      decoration: underLine ? TextDecoration.underline : TextDecoration.none);
}
