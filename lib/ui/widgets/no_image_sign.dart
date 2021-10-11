import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

Widget buildNoImageSign() {
  return Container(
    alignment: Alignment.center,
    color: Colors.grey.shade200,
    child: Icon(
      FlutterRemix.restaurant_2_line,
      size: 80,
      color: Colors.grey.shade400,
    ),
  );
}
