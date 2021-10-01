import 'package:uuid/uuid.dart';

String generateNewRecipeID() {
  return Uuid().v4();
}

class NewRecipe {
  final String name;
  final List<Ingredient> ingredients;
  final List<String> cookingSteps;

  NewRecipe({
    required this.name,
    required this.ingredients,
    required this.cookingSteps,
  });
}

class UpdatedRecipe {
  final String id;
  final String? name;
  final List<Ingredient> ingredients;
  final List<String> cookingSteps;

  UpdatedRecipe({
    required this.id,
    required this.name,
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
