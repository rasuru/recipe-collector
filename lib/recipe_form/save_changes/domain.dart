import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

String generateNewRecipeID() {
  return Uuid().v4();
}

class Recipe {
  final String id;
  final String name;
  final Option<Uint8List> optionalCoverImage;
  final List<Ingredient> ingredients;
  final List<String> cookingSteps;
  final Duration preparationTime;
  final Duration cookingTime;
  final Duration totalTime;

  Recipe({
    required this.id,
    required this.name,
    required this.optionalCoverImage,
    required this.ingredients,
    required this.cookingSteps,
    required this.preparationTime,
    required this.cookingTime,
    required this.totalTime,
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
