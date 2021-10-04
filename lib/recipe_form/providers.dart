import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'close_form.dart';
import 'cooking_step_field/state.dart';
import 'cover_image_picker/state.dart';
import 'domain.dart';
import 'ingredient_field/state.dart';
import 'name_field/state.dart';
import 'open_form/use_case.dart';
import 'reset_form.dart';
import 'state/cooking_step_field_list.dart';
import 'state/ingredient_field_list.dart';

List<Provider> createRecipeFormProviders({
  required BuildContext context,
  required EditedRecipe editedRecipe,
}) {
  return [
    Provider<GlobalKey<FormState>>(create: (_) => GlobalKey<FormState>()),
    Provider<ResetRecipeForm>(
      create: (context) => ResetRecipeForm(
        formKey: context.read<GlobalKey<FormState>>(),
        sheetController: context.read<SheetController>(),
      ),
    ),
    Provider<CloseRecipeForm>(
      create: (context) => CloseRecipeForm(
        openRecipeForm: context.read<OpenRecipeFormUseCase>(),
        sheetController: context.read<SheetController>(),
      ),
    ),
    Provider<EditedRecipe>.value(value: editedRecipe),
    Provider<Name$>(
      create: (_) => Name$(
        textEditingController: TextEditingController(
          text: editedRecipe.name,
        ),
      ),
    ),
    Provider<IngredientFieldList$>(
      create: (_) =>
          IngredientFieldList$(editedRecipe.ingredients.map((ingredient) {
        return IngredientField$(
          initialName: ingredient.name,
          initialAmount: ingredient.amount,
        );
      }).toList()),
    ),
    Provider<CookingStepFieldList$>(
      create: (_) => CookingStepFieldList$(editedRecipe.cookingSteps
          .map((step) => CookingStepField$(initialText: step))
          .toList()),
    ),
    Provider<CoverImage$>(create: (_) => CoverImage$()),
  ];
}
