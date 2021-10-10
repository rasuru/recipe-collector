import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/extensions/global.dart';
import 'package:recipe_collector/progress.dart';

import '../../close_form.dart';
import '../../cover_image_picker/state.dart';
import '../../name_field/state.dart';
import '../../preparation_time_field/state.dart';
import '../../state/cooking_step_field_list.dart';
import '../../state/ingredient_field_list.dart';
import '../controller.dart';
import '../state.dart';

class SaveChangesButton extends StatefulWidget {
  final bool Function() validate;
  final String recipeID;

  const SaveChangesButton({
    Key? key,
    required this.recipeID,
    required this.validate,
  }) : super(key: key);

  @override
  _SaveChangesButtonState createState() => _SaveChangesButtonState();
}

class _SaveChangesButtonState extends State<SaveChangesButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveChangesProgress$, Progress>(
      builder: (context, progress) {
        return ElevatedButton.icon(
          onPressed: () {
            if (widget.validate()) {
              _saveChanges();
              context.read<CloseRecipeForm>()();
            }
          }.nullifyIf(progress.isActive),
          icon: Icon(Icons.edit),
          label: Text('Save'),
        );
      },
    );
  }

  void _saveChanges() {
    final saveChanges = context.read<SaveChanges>().update;

    saveChanges(
      id: widget.recipeID,
      name: context.read<Name$>().state,
      optionalCoverImage: context.read<CoverImage$>().state,
      ingredients: context.read<IngredientFieldList$>().ingredients,
      cookingSteps: context.read<CookingStepFieldList$>().steps,
      preparationTime: context.read<PreparationTime$>().state,
    );
  }
}
