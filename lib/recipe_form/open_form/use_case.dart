import 'package:recipe_collector/progress.dart';

import '../domain.dart';

class OpenRecipeFormUseCase {
  final Future<EditedRecipe> Function(String) retrieveRecipe;
  final void Function(Progress<EditedRecipe>) presentProgress;
  EditedRecipe _lastOpenRecipe = EditedRecipe.empty();

  OpenRecipeFormUseCase({
    required this.retrieveRecipe,
    required this.presentProgress,
  });

  Future<void> call(String id) async {
    presentProgress(Active());
    presentCompleted(await retrieveRecipe(id));
  }

  void emptyForm() {
    presentCompleted(EditedRecipe.empty());
  }

  void resetForm() {
    presentCompleted(_lastOpenRecipe);
  }

  void presentCompleted(EditedRecipe recipe) {
    _lastOpenRecipe = recipe;
    presentProgress(Completed(recipe));
  }
}
