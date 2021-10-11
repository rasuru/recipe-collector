import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

String generateNewRecipeID() {
  return Uuid().v4();
}

class NewRecipe {
  final String name;
  final Option<Uint8List> optionalCoverImage;
  final List<Ingredient> ingredients;
  final List<String> cookingSteps;
  final Duration preparationTime;
  final Duration cookingTime;

  NewRecipe({
    required this.name,
    required this.optionalCoverImage,
    required this.ingredients,
    required this.cookingSteps,
    required Option<Duration> preparationTime,
    required Option<Duration> cookingTime,
  })  : preparationTime = preparationTime | Duration.zero,
        cookingTime = cookingTime | Duration.zero;
}

class Ingredient {
  final String name;
  final String? amount;

  Ingredient({
    required this.name,
    required this.amount,
  });
}
