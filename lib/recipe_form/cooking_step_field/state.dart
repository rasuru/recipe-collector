import 'package:flutter/material.dart';

class CookingStepField$ {
  final TextEditingController text$;

  CookingStepField$({
    required String? initialText,
  }) : text$ = TextEditingController(text: initialText);

  CookingStepField$.empty() : text$ = TextEditingController();
}

class CookingStepNumber {
  final int index;
  String get number => '${index + 1}';

  CookingStepNumber.index(this.index);
}
