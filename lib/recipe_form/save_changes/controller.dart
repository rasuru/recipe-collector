import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../state/ingredient_field_list.dart';
import 'use_case.dart';

class SaveChanges {
  final SaveChangesUseCase useCase;

  SaveChanges(this.useCase);

  void call({
    required Recipe recipe,
    required String? optionalID,
  }) {
    if (optionalID == null) {
      store(recipe);
    } else {
      update(optionalID, recipe);
    }
  }

  void store(Recipe recipe) {
    useCase.store(recipe.toEntity());
  }

  void update(String id, Recipe recipe) {
    useCase.update(id, recipe.toEntity());
  }
}

class Recipe {
  final String name;
  final Option<Uint8List> optionalCoverImage;
  final List<Ingredient> ingredients;
  final List<String> cookingSteps;
  final Option<Duration> preparationTime;
  final Option<Duration> cookingTime;
  final Option<Duration> totalTime;

  Recipe({
    required this.name,
    required this.optionalCoverImage,
    required this.ingredients,
    required this.cookingSteps,
    required this.preparationTime,
    required this.cookingTime,
    required this.totalTime,
  });

  NewRecipe toEntity() {
    return NewRecipe(
      name: name,
      optionalCoverImage: optionalCoverImage,
      ingredients: ingredients.map((ingredient) {
        return IngredientModel(
          name: ingredient.name,
          amount: ingredient.amount.isEmpty ? null : ingredient.amount,
        );
      }).toList(),
      cookingSteps: cookingSteps,
      preparationTime: preparationTime | Duration.zero,
      cookingTime: cookingTime | Duration.zero,
      totalTime: totalTime | Duration.zero,
    );
  }
}
