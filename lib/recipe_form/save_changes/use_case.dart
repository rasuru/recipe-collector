import 'package:dartz/dartz.dart';
import 'package:recipe_collector/progress.dart';

import 'domain.dart';

class SaveChangesUseCase {
  final Future<void> Function({
    required String id,
    required String? name,
    required List<Ingredient> ingredients,
  }) update;
  final Future<void> Function({
    required String id,
    required String name,
    required List<Ingredient> ingredients,
  }) store;
  final void Function(Progress) present;

  SaveChangesUseCase({
    required this.update,
    required this.store,
    required this.present,
  });

  Future<void> call({
    required Option<String> maybeID,
    required String? name,
    required List<Ingredient> ingredients,
  }) async {
    present(Active());
    await maybeID.fold(
      () => store(
        id: generateNewRecipeID(),
        name: name!,
        ingredients: ingredients,
      ),
      (id) => update(id: id, name: name, ingredients: ingredients),
    );
    present(Completed(null));
  }
}
