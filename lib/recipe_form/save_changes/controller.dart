import '../state/ingredient_field_list.dart';
import 'domain.dart' as domain;
import 'use_case.dart';

class SaveChanges {
  final SaveChangesUseCase useCase;

  SaveChanges(this.useCase);

  void store({
    required String name,
    required List<Ingredient> ingredients,
    required List<String> cookingSteps,
  }) {
    useCase.store(domain.NewRecipe(
      name: name,
      ingredients: ingredients.map((ingredient) {
        return domain.Ingredient(
          name: ingredient.name,
          amount: ingredient.amount.isEmpty ? null : ingredient.amount,
        );
      }).toList(),
      cookingSteps: cookingSteps,
    ));
  }

  void update({
    required String id,
    required String? name,
    required List<Ingredient> ingredients,
    required List<String> cookingSteps,
  }) {
    useCase.update(domain.UpdatedRecipe(
      id: id,
      name: name,
      ingredients: ingredients.map((ingredient) {
        return domain.Ingredient(
          name: ingredient.name,
          amount: ingredient.amount.isEmpty ? null : ingredient.amount,
        );
      }).toList(),
      cookingSteps: cookingSteps,
    ));
  }
}
