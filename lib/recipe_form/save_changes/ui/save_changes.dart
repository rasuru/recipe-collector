import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../cooking_time_field/state.dart';
import '../../cover_image_picker/state.dart';
import '../../name_field/state.dart';
import '../../preparation_time_field/state.dart';
import '../../state/cooking_step_field_list.dart';
import '../../state/ingredient_field_list.dart';
import '../../total_time_field/state.dart';
import '../controller.dart';

void saveChanges(BuildContext context, {String? recipeID}) {
  final saveChanges = context.read<SaveChanges>();

  saveChanges(
    optionalID: recipeID,
    recipe: Recipe(
      name: context.read<Name$>().state,
      optionalCoverImage: context.read<CoverImage$>().state,
      ingredients: context.read<IngredientFieldList$>().ingredients,
      cookingSteps: context.read<CookingStepFieldList$>().steps,
      preparationTime: context.read<PreparationTime$>().state,
      cookingTime: context.read<CookingTime$>().state,
      totalTime: context.read<TotalTime$>().state,
    ),
  );
}
