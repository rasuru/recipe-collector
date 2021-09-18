import 'package:provider/provider.dart';

import 'state.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createDeleteRecipeProviders() {
  return [
    Provider<DeleteRecipeProgress$>(create: (_) => DeleteRecipeProgress$()),
    Provider<DeleteRecipeUseCase>(
      create: (context) => DeleteRecipeUseCase(
        present: context.read<DeleteRecipeProgress$>(),
        deleteRecipe: deleteRecipe,
      ),
    ),
  ];
}
