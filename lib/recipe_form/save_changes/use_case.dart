import 'package:recipe_collector/progress.dart';

import 'domain.dart';

class SaveChangesUseCase {
  final Future<void> Function(UpdatedRecipe) _update;
  final Future<void> Function(String, NewRecipe) _store;
  final void Function(Progress) present;

  SaveChangesUseCase({
    required Future<void> Function(UpdatedRecipe) update,
    required Future<void> Function(String, NewRecipe) store,
    required this.present,
  })  : _store = store,
        _update = update;

  Future<void> store(NewRecipe recipe) async {
    present(Active());
    await _store(generateNewRecipeID(), recipe);
    present(Completed(null));
  }

  Future<void> update(UpdatedRecipe recipe) async {
    present(Active());
    await _update(recipe);
    present(Completed(null));
  }
}
