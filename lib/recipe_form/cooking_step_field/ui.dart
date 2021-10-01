import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/ui/theme.dart';

import 'domain.dart';
import 'state.dart';
import '../state/cooking_step_field_list.dart';

class CookingStepField extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = context.watch<UITheme>();

    return TextFormField(
      controller: context.watch<CookingStepField$>().text$,
      decoration: InputDecoration(
        labelText: 'Cooking Step #' + context.watch<CookingStepNumber>().number,
        contentPadding: theme.inputPadding.copyWith(right: 0),
        suffixIcon: Builder(builder: buildRemoveButton),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (name) => validateCookingStep(name ?? ''),
    );
  }

  Widget buildRemoveButton(BuildContext context) {
    return Visibility(
      visible: context.watch<CookingStepFieldList$>().userCanRemoveFields,
      child: SizedBox(
        width: 24,
        child: TextButton(
          onPressed: () => context.read<CookingStepFieldList$>().removeField(
                context.read<CookingStepNumber>().index,
              ),
          child: Icon(Icons.delete),
        ),
      ),
    );
  }
}
