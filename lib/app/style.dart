import 'package:flutter/material.dart';
// Define multi-used style like colors or text styles
// maybe we can make another style file for app's theme selecting function

Color mainPink = Color.fromRGBO(255, 200, 200, 1);
Color mainGreen = Color.fromRGBO(209, 255, 237, 1);
Color white = Colors.white;
Color grey48 = Color.fromRGBO(48, 48, 48, 1.0);
Color grey138 = Color.fromRGBO(138, 138, 138, 1.0);
Color grey204 = Color.fromRGBO(204, 204, 204, 1.0);
Color grey217 = Color.fromRGBO(217, 217, 217, 1.0);
Color grey247 = Color.fromRGBO(247, 247, 247, 1.0);
Color navyDark = Color.fromRGBO(10, 20, 36, 1.0);
Color balck = Color.fromRGBO(34, 34, 34, 1.0);

// why not?
const double defaultTextSize = 12;
const FontWeight defaultfontWeight = FontWeight.normal;
TextStyle defaultText(
    {double size = defaultTextSize,
    FontWeight fontWeight = FontWeight.normal,
    required Color color}) {
  return TextStyle(fontSize: size, fontWeight: fontWeight, color: color);
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

TextStyle whiteText(
    {double size = 12, FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(fontSize: size, fontWeight: fontWeight, color: white);
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
