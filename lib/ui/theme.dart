import 'package:flutter/material.dart';

class UITheme {
  final borderWidth = 2.0;
  final borderRadius = BorderRadius.circular(5.0);
  final success = UISuccess();
  final flutterTheme = ThemeData(
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 20,
        right: 20,
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(40),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
        borderRadius: BorderRadius.circular(40),
      ),
    ),
  );
}

class UISuccess {
  final colors = UISuccessColors();
}

class UISuccessColors {
  final background = Colors.green.shade100;
  final shadow = Colors.green.shade100;
  final border = Colors.green.shade200;
  final text = Colors.green.shade800;
}
