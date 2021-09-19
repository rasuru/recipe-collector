import 'package:recipe_collector/progress.dart';

import '../domain.dart';

class OpenRecipeFormUseCase {
  final Future<EditedRecipe> Function(String) retrieveRecipe;
  final void Function(Progress<EditedRecipe>) presentProgress;

  OpenRecipeFormUseCase({
    required this.retrieveRecipe,
    required this.presentProgress,
  });

  Future<void> call(String id) async {
    presentProgress(Active());
    presentProgress(Completed(
      await retrieveRecipe(id),
    ));
  }

  void emptyForm() {
    presentProgress(Completed(EditedRecipe.empty()));
  }
}
