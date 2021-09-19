import 'package:recipe_collector/progress.dart';
import 'package:recipe_collector/recipe_form/open_form/use_case.dart';

class SaveChangesUseCase {
  final Future<void> Function({
    required String id,
    required String? name,
  }) update;
  final void Function(Progress) present;
  final OpenRecipeFormUseCase openRecipeForm;

  SaveChangesUseCase({
    required this.update,
    required this.present,
    required this.openRecipeForm,
  });

  Future<void> call({
    required String id,
    required String? name,
  }) async {
    present(Active());
    await update(
      id: id,
      name: name,
    );
    present(Completed(null));
    openRecipeForm.emptyForm();
  }
}
