import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:recipe_collector/progress.dart';

import 'domain.dart' as domain;

class SaveChangesUseCase {
  final Future<void> Function(domain.Recipe) _update;
  final Future<void> Function(domain.Recipe) _store;
  final void Function(Progress) present;

  SaveChangesUseCase({
    required Future<void> Function(domain.Recipe) update,
    required Future<void> Function(domain.Recipe) store,
    required this.present,
  })  : _store = store,
        _update = update;

  Future<void> store(NewRecipe recipe) async {
    present(Active());
    await _store(recipe.toEntity(domain.generateNewRecipeID()));
    present(Completed(null));
  }

  Future<void> update(String id, NewRecipe recipe) async {
    present(Active());
    await _update(recipe.toEntity(id));
    present(Completed(null));
  }
}

class NewRecipe {
  final String name;
  final Option<Uint8List> optionalCoverImage;
  final List<IngredientModel> ingredients;
  final List<String> cookingSteps;
  final Duration preparationTime;
  final Duration cookingTime;
  final Duration totalTime;

  NewRecipe({
    required this.name,
    required this.optionalCoverImage,
    required this.ingredients,
    required this.cookingSteps,
    required this.preparationTime,
    required this.cookingTime,
    required this.totalTime,
  });

  domain.Recipe toEntity(String id) {
    return domain.Recipe(
      id: id,
      name: name,
      optionalCoverImage: optionalCoverImage,
      ingredients: ingredients.map((i) => i.toEntity()).toList(),
      cookingSteps: cookingSteps,
      preparationTime: preparationTime,
      cookingTime: cookingTime,
      totalTime: totalTime,
    );
  }
}

class IngredientModel {
  final String name;
  final String? amount;

  IngredientModel({
    required this.name,
    required this.amount,
  });

  domain.Ingredient toEntity() {
    return domain.Ingredient(name: name, amount: amount);
  }
}
