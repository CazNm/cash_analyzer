import 'package:flutter/material.dart';

Color mainPink = Color.fromRGBO(255, 200, 200, 1);
Color mainGreen = Color.fromRGBO(209, 255, 237, 1);
Color white = Colors.white;
Color grey138 = Color.fromRGBO(138, 138, 138, 1.0);
Color grey204 = Color.fromRGBO(204, 204, 204, 1.0);
Color grey217 = Color.fromRGBO(217, 217, 217, 1.0);
Color grey247 = Color.fromRGBO(247, 247, 247, 1.0);

TextStyle grey138Text(
    {double size = 12, FontWeight fontWeight = FontWeight.normal}) {
  return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: Color.fromRGBO(138, 138, 138, 1.0));
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
