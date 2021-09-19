import 'package:provider/provider.dart';
import 'package:recipe_collector/extensions/sliding_sheet.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'state.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createOpenFormProviders() {
  return [
    Provider<OpenRecipeFormProgress$>(
      create: (context) => OpenRecipeFormProgress$(
        showForm: context.read<SheetController>().fullyExpand,
      ),
    ),
    Provider<OpenRecipeFormUseCase>(
      create: (context) => OpenRecipeFormUseCase(
        retrieveRecipe: queryRecipe,
        presentProgress: context.read<OpenRecipeFormProgress$>(),
      ),
    ),
  ];
}
