import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/recipe_form/state/ingredient_field_list.dart';
import 'package:recipe_collector/ui/theme.dart';

import '../state.dart';
import 'domain.dart';

class IngredientNameField extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = context.watch<UITheme>();

    return TextFormField(
      controller: context.watch<IngredientField$>().name$,
      decoration: InputDecoration(
        labelText: 'Ingredient #' + context.watch<IngredientNumber>().number,
        contentPadding: theme.inputPadding.copyWith(right: 0),
        suffixIcon: Builder(builder: buildRemoveButton),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (name) => validateIngredientName(name ?? ''),
    );
  }

  Widget buildRemoveButton(BuildContext context) {
    return Visibility(
      visible: context.watch<IngredientFieldList$>().userCanRemoveFields,
      child: SizedBox(
        width: 24,
        child: TextButton(
          onPressed: () => context.read<IngredientFieldList$>().removeField(
                context.read<IngredientNumber>().index,
              ),
          child: Icon(FlutterRemix.delete_bin_line),
        ),
      ),
    );
  }
}
