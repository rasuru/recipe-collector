import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain.dart';
import 'name_field/state.dart';
import 'save_changes/providers.dart';

List<Provider> createRecipeFormProviders({
  required BuildContext context,
  required EditedRecipe editedRecipe,
}) {
  return [
    Provider<EditedRecipe>.value(value: editedRecipe),
    Provider<Name$>(
      create: (_) => Name$(
        textEditingController: TextEditingController(
          text: editedRecipe.name,
        ),
      ),
    ),
    ...createSaveChangesProviders(),
  ];
}
