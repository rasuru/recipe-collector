import 'package:recipe_collector/progress.dart';
import 'domain.dart';

class AddRecipeUseCase {
  final Future<void> Function({
    required String id,
    required String name,
    required List<Ingredient> ingredients,
  }) store;
  final void Function(Progress) present;

  AddRecipeUseCase({
    required this.store,
    required this.present,
  });

  Future<void> call({
    required String name,
    required List<Ingredient> ingredients,
  }) async {
    present(Active());
    await store(
      id: generateNewRecipeID(),
      name: name,
      ingredients: ingredients,
    );
    present(Completed(null));
  }
}
