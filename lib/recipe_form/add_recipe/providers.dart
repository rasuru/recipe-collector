import 'package:provider/provider.dart';

import 'controller.dart';
import 'state.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createAddRecipeProviders() {
  return [
    Provider<AddRecipeProgress$>(create: (_) => AddRecipeProgress$()),
    Provider<AddRecipeController>(
      create: (context) => AddRecipeController(
        AddRecipeUseCase(
          present: context.read<AddRecipeProgress$>(),
          store: insertRecipe,
        ),
      ),
    ),
  ];
}
