import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_collector/progress.dart';

import '../domain.dart' as domain;

class OpenRecipeFormProgress$ extends Cubit<Progress<EditedRecipe>> {
  final void Function() showForm;

  OpenRecipeFormProgress$({
    required this.showForm,
  }) : super(Idle());

  void call(Progress<domain.EditedRecipe> progress) {
    if (progress.isActive) showForm();
    emit(progress.map((recipe) {
      return EditedRecipe(
        name: recipe.name,
        maybeID: recipe.maybeID,
        ingredients: recipe.ingredients.map((ingredient) {
          return EditedIngredient(
            name: ingredient.name,
            amount: ingredient.amount,
          );
        }).toList(),
        cookingSteps: recipe.cookingSteps,
        optionalCoverImage: recipe.optionalCoverImage,
      );
    }));
  }
}

class EditedRecipe {
  final Option<String> maybeID;
  final String name;
  final Option<Uint8List> optionalCoverImage;
  final List<EditedIngredient> ingredients;
  final List<String> cookingSteps;

  EditedRecipe({
    required this.maybeID,
    required this.name,
    required this.optionalCoverImage,
    required this.ingredients,
    required this.cookingSteps,
  });

  bool get isNewRecipe => maybeID.isNone();
}

class EditedIngredient {
  final String name;
  final String? amount;

  EditedIngredient({
    required this.name,
    required this.amount,
  });

  EditedIngredient.empty()
      : name = '',
        amount = '';
}
