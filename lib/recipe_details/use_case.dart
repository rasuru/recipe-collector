import 'package:recipe_collector/progress.dart';

import 'domain.dart';

class ViewRecipeUseCase {
  final void Function(Progress<Recipe>) present;
  final Future<Recipe> Function(String) retrieve;

  ViewRecipeUseCase({
    required this.present,
    required this.retrieve,
  });

  Future<void> call(String id) async {
    present(Active());
    present(Completed(await retrieve(id)));
  }
}
