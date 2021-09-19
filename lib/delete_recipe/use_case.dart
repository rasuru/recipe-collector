import 'package:recipe_collector/progress.dart';

class DeleteRecipeUseCase {
  final Future<void> Function(String) deleteRecipe;
  final void Function({
    required String id,
    required Progress progress,
  }) present;

  DeleteRecipeUseCase({
    required this.deleteRecipe,
    required this.present,
  });

  Future<void> call(String id) async {
    present(id: id, progress: Active());
    await deleteRecipe(id);
    present(id: id, progress: Completed(null));
  }
}
