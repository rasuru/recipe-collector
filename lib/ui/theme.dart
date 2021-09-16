import 'package:flutter/material.dart';

class UITheme {
  final borderWidth = 2.0;
  final borderRadius = BorderRadius.circular(5.0);
  final success = UISuccess();
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
