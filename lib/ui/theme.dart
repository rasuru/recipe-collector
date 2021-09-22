import 'package:flutter/material.dart';
import 'package:recipe_collector/ui/padding.dart';

class UITheme {
  final borderWidth = 2.0;
  double get borderRadius => 5.0;
  final success = UISuccess();
  ThemeData get flutterTheme => ThemeData(
        brightness: Brightness.light,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: inputPadding,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      );

  EdgeInsets get inputPadding => paddingOf(vertical: 5, horizontal: 15);
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
