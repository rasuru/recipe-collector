import 'package:flutter/material.dart';

class IngredientField$ {
  final TextEditingController name$;
  final TextEditingController amount$;

  IngredientField$({
    required this.name$,
    required this.amount$,
  });

  IngredientField$.empty()
      : name$ = TextEditingController(),
        amount$ = TextEditingController();
}

class IngredientNumber {
  final int index;
  String get number => '${index + 1}';

  IngredientNumber.index(this.index);
}
