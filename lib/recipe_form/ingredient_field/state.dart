import 'package:flutter/material.dart';

class IngredientField$ {
  final TextEditingController name$;
  final TextEditingController amount$;

  IngredientField$({
    required String? initialName,
    required String? initialAmount,
  })  : name$ = TextEditingController(text: initialName),
        amount$ = TextEditingController(text: initialAmount);

  IngredientField$.empty()
      : name$ = TextEditingController(),
        amount$ = TextEditingController();
}

class IngredientNumber {
  final int index;
  String get number => '${index + 1}';

  IngredientNumber.index(this.index);
}
