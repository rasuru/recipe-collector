import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'close_form.dart';
import 'cooking_time_field/providers.dart';
import 'cover_image_picker/state.dart';
import 'name_field/providers.dart';
import 'open_form/state.dart';
import 'open_form/use_case.dart';
import 'preparation_time_field/providers.dart';
import 'state/cooking_step_field_list.dart';
import 'state/ingredient_field_list.dart';

List<Provider> createRecipeFormProviders({
  required BuildContext context,
  required EditedRecipe editedRecipe,
}) {
  return [
    Provider<GlobalKey<FormState>>(create: (_) => GlobalKey<FormState>()),
    Provider<CloseRecipeForm>(
      create: (context) => CloseRecipeForm(
        openRecipeForm: context.read<OpenRecipeFormUseCase>(),
        sheetController: context.read<SheetController>(),
      ),
    ),
    Provider<EditedRecipe>.value(value: editedRecipe),
    ...createNameFieldProviders(),
    Provider<IngredientFieldList$>(
      create: (_) => IngredientFieldList$(editedRecipe.ingredients),
    ),
    Provider<CookingStepFieldList$>(
      create: (_) => CookingStepFieldList$(editedRecipe.cookingSteps),
    ),
    Provider<CoverImage$>(
      create: (_) => CoverImage$(editedRecipe.optionalCoverImage),
    ),
    ...createPreparationTimeFieldProviders(),
    ...createCookingTimeFieldProviders(),
  ];
}
