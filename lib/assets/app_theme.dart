import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Color(0xfffcfcff);
  static Color lightAccent = Colors.blueGrey[900];
  static Color darkAccent = Colors.white;
  static Color lightBG = Color(0xfffcfcff);
  static Color badgeColor = Colors.red;
  static Color fontPrimaryColor = Colors.black;

  static Color defaultButton = Colors.blue[50];

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: primary,
    accentColor: lightAccent,
    cursorColor: lightAccent,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: fontPrimaryColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
