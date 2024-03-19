import 'package:flutter/material.dart';

class Styles {
  static TextStyle lockHeader = baseText(weight: FontWeight.bold);

  static TextStyle itemLabel = baseText(weight: FontWeight.bold);

  static TextStyle appBarLabel = baseText(size: 18.0);

  static TextStyle errorText = baseText(size: 16.0, color: Colors.red);

  static TextStyle hintText = baseText(color: Colors.grey);

  static TextStyle saveButtonTextColor = baseText(color: Colors.white);

  static TextStyle baseText({
    double size = 14.0,
    Color? color = const Color(0xFF000000),
    FontWeight weight = FontWeight.normal,
  }) {
    return TextStyle(
        fontSize: size, color: color, fontWeight: weight, fontFamily: "Roboto");
  }

  static ButtonStyle saveButtonColor = const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Colors.cyan));

  static Color? lockColor = Colors.cyan[200];

  static Color? panelColor = Colors.cyan[50];

  static Color? backgroundColor = Colors.white;

  static Color? appBarColor = Colors.cyan;

  static ThemeData appTheme = ThemeData(
    primarySwatch: Colors.cyan,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 68, 237, 243)),
    useMaterial3: true,
  );
}
