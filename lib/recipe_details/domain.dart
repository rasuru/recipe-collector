import 'dart:typed_data';

import 'package:dartz/dartz.dart';

class Recipe {
  final String id;
  final String name;
  final Option<Uint8List> optionalCoverImage;
  final List<Ingredient> ingredients;
  final List<String> cookingSteps;

  Recipe({
    required this.id,
    required this.name,
    required this.optionalCoverImage,
    required this.ingredients,
    required this.cookingSteps,
  });
}

class Ingredient {
  final String name;
  final String? amount;

  Ingredient({
    required this.name,
    required this.amount,
  });
}
