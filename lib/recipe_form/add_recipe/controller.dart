import 'domain.dart' as domain;
import 'use_case.dart';

class AddRecipeController {
  final AddRecipeUseCase useCase;

  AddRecipeController(this.useCase);

  void call({
    required String? name,
    required List<Ingredient> ingredients,
  }) =>
      useCase(
        name: name ?? '',
        ingredients: ingredients.map((ingredient) {
          return domain.Ingredient(
            name: ingredient.name,
            amount: ingredient.amount.isEmpty ? null : ingredient.amount,
          );
        }).toList(),
      );
}

class Ingredient {
  final String name;
  final String amount;

  Ingredient({
    required this.name,
    required this.amount,
  });
}
