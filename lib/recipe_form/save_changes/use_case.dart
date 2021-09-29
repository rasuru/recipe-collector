import 'package:recipe_collector/progress.dart';

import 'domain.dart';

class SaveChangesUseCase {
  final Future<void> Function({
    required String id,
    required String? name,
    required List<Ingredient> ingredients,
  }) update;
  final void Function(Progress) present;

  SaveChangesUseCase({
    required this.update,
    required this.present,
  });

  Future<void> call({
    required String id,
    required String? name,
    required List<Ingredient> ingredients,
  }) async {
    present(Active());
    await update(
      id: id,
      name: name,
      ingredients: ingredients,
    );
    present(Completed(null));
  }
}
