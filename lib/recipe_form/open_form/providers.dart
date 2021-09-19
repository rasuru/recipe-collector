import 'package:provider/provider.dart';

import 'state.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createOpenFormProviders() {
  return [
    Provider<OpenRecipeFormProgress$>(create: (_) => OpenRecipeFormProgress$()),
    Provider<OpenRecipeFormUseCase>(
      create: (context) => OpenRecipeFormUseCase(
        retrieveRecipe: queryRecipe,
        presentProgress: context.read<OpenRecipeFormProgress$>(),
      ),
    ),
  ];
}
