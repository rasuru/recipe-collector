import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../state/ingredient_field_list.dart';
import 'domain.dart' as domain;
import 'use_case.dart';

class SaveChanges {
  final SaveChangesUseCase useCase;

  SaveChanges(this.useCase);

  void store({
    required String name,
    required Option<Uint8List> optionalCoverImage,
    required List<Ingredient> ingredients,
    required List<String> cookingSteps,
    required Option<Duration> preparationTime,
  }) {
    useCase.store(domain.NewRecipe(
      name: name,
      optionalCoverImage: optionalCoverImage,
      ingredients: ingredients.map((ingredient) {
        return domain.Ingredient(
          name: ingredient.name,
          amount: ingredient.amount.isEmpty ? null : ingredient.amount,
        );
      }).toList(),
      cookingSteps: cookingSteps,
      preparationTime: preparationTime,
    ));
  }

  void update({
    required String id,
    required String name,
    required Option<Uint8List> optionalCoverImage,
    required List<Ingredient> ingredients,
    required List<String> cookingSteps,
    required Option<Duration> preparationTime,
  }) {
    useCase.update(
      id,
      domain.NewRecipe(
        name: name,
        optionalCoverImage: optionalCoverImage,
        ingredients: ingredients.map((ingredient) {
          return domain.Ingredient(
            name: ingredient.name,
            amount: ingredient.amount.isEmpty ? null : ingredient.amount,
          );
        }).toList(),
        cookingSteps: cookingSteps,
        preparationTime: preparationTime,
      ),
    );
  }
}
