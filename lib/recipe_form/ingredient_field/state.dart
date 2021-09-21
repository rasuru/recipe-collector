import 'package:flutter/material.dart';

class IngredientField$ {
  final TextEditingController name$;
  final TextEditingController amount$;

  IngredientField$({
    required this.name$,
    required this.amount$,
  });
}

class IngredientNumber {
  final String number;

  IngredientNumber.index(int index) : number = '${index + 1}';
}
