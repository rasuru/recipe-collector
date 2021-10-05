import 'dart:typed_data';

import 'package:dartz/dartz.dart';

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

  EditedRecipe.empty()
      : maybeID = None(),
        name = '',
        optionalCoverImage = None(),
        ingredients = [EditedIngredient.empty()],
        cookingSteps = [''];

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
