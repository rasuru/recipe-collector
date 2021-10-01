import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/extensions/global.dart';
import 'package:recipe_collector/progress.dart';

import '../../close_form.dart';
import '../../name_field/state.dart';
import '../../state/cooking_step_field_list.dart';
import '../../state/ingredient_field_list.dart';
import '../controller.dart';
import '../state.dart';

class AddRecipeButton extends StatefulWidget {
  final bool Function() validate;

  const AddRecipeButton({
    Key? key,
    required this.validate,
  }) : super(key: key);

  @override
  _AddRecipeButtonState createState() => _AddRecipeButtonState();
}

class _AddRecipeButtonState extends State<AddRecipeButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveChangesProgress$, Progress>(
      builder: (context, progress) {
        return ElevatedButton(
          onPressed: () {
            if (widget.validate()) {
              _addRecipe();
              context.read<CloseRecipeForm>()();
            }
          }.nullifyIf(progress.isActive),
          child: Icon(Icons.check),
        );
      },
    );
  }

  void _addRecipe() {
    final saveChanges = context.read<SaveChanges>().store;

    saveChanges(
      name: context.read<Name$>().state,
      ingredients: context.read<IngredientFieldList$>().ingredients,
      cookingSteps: context.read<CookingStepFieldList$>().steps,
    );
  }
}
