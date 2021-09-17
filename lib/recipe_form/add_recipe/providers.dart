import 'package:provider/provider.dart';

import 'controller.dart';
import 'model.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createAddRecipeProviders() {
  final addRecipe$ = AddRecipeProgress$();

  return [
    Provider<AddRecipeController>(
      create: (_) => AddRecipeController(
        AddRecipeUseCase(
          present: addRecipe$,
          store: insertRecipe,
        ),
      ),
    ),
    Provider<AddRecipeProgress$>(create: (_) => addRecipe$),
  ];
}
