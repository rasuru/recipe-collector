import 'package:provider/provider.dart';

import 'state.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createRecipeDetailsProviders() {
  return [
    Provider<ViewRecipeProgress$>(
      create: (_) => ViewRecipeProgress$(),
    ),
    Provider<ViewRecipeUseCase>(
      create: (context) => ViewRecipeUseCase(
        present: context.read<ViewRecipeProgress$>().emit,
        retrieve: queryRecipe,
      ),
    ),
  ];
}
