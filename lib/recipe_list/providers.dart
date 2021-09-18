import 'package:provider/provider.dart';
import 'package:recipe_collector/recipe_list/controller.dart';

import 'state.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createRecipeListProviders() {
  return [
    Provider<RecipeList$>(create: (_) => RecipeList$()),
    Provider<ViewRecipeListController>(
      create: (context) => ViewRecipeListController(
        ViewRecipeListUseCase(
          present: context.read<RecipeList$>(),
          retrieve: queryRecipes,
        ),
      ),
    ),
  ];
}
