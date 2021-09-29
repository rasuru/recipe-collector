import 'package:dartz/dartz.dart';

class EditedRecipe {
  final Option<String> maybeID;
  final String name;
  final List<EditedIngredient> ingredients;

  EditedRecipe({
    required this.maybeID,
    required this.name,
    required this.ingredients,
  });

  EditedRecipe.empty()
      : maybeID = None(),
        name = '',
        ingredients = [];

  bool get isNewRecipe => maybeID.isNone();
}

class EditedIngredient {
  final String name;
  final String? amount;

  EditedIngredient({
    required this.name,
    required this.amount,
  });
}
