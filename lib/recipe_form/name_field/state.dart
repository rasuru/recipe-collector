import 'package:flutter/material.dart';

class Name$ {
  final TextEditingController textEditingController;

  Name$({
    required this.textEditingController,
  });

  String get state => textEditingController.text;
  void call(String name) => textEditingController.text = name;
}
