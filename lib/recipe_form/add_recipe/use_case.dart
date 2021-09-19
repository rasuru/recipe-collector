import 'package:recipe_collector/progress.dart';
import 'domain.dart';

class AddRecipeUseCase {
  final Future<void> Function({
    required String id,
    required String name,
  }) store;
  final void Function(Progress) present;

  AddRecipeUseCase({
    required this.store,
    required this.present,
  });

  Future<void> call({
    required String name,
  }) async {
    present(Active());
    await store(
      id: generateNewRecipeID(),
      name: name,
    );
    present(Completed(null));
  }
}
