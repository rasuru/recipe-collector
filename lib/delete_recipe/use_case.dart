import 'package:recipe_collector/progress.dart';

class DeleteRecipeUseCase {
  final Future<void> Function(String) deleteRecipe;
  final void Function(Progress) present;

  DeleteRecipeUseCase({
    required this.deleteRecipe,
    required this.present,
  });

  Future<void> call(String id) async {
    present(Active());
    await deleteRecipe(id);
    present(Completed(null));
  }
}
