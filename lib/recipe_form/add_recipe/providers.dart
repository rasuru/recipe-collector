import 'package:provider/provider.dart';

import 'controller.dart';
import 'model.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createAddRecipeProviders() {
  final addRecipe$ = AddRecipe$();

  return [
    Provider<AddRecipeController>(
      create: (_) => AddRecipeController(
        AddRecipeUseCase(
          present: addRecipe$,
          store: insertRecipe,
        ),
      ),
    ),
    Provider<AddRecipe$>(create: (_) => addRecipe$),
    Provider<RecipeName$>(create: (_) => RecipeName$()),
  ];
}
