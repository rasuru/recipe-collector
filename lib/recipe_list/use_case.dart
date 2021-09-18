import 'package:recipe_collector/progress.dart';

import 'domain.dart';

class ViewRecipeListUseCase {
  final Stream<Future<List<Recipe>>> Function() retrieve;
  final void Function(Progress<List<Recipe>>) present;

  ViewRecipeListUseCase({
    required this.retrieve,
    required this.present,
  });

  Future<void> call() async {
    present(Idle());
    await for (final list in retrieve()) {
      present(Active());
      present(Completed(await list));
    }
    present(Idle());
  }
}
