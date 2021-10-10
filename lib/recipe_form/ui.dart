import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/delete_recipe/state.dart';
import 'package:recipe_collector/ui/padding.dart';

import 'close_form.dart';
import 'cooking_step_field/state.dart';
import 'cooking_step_field/ui.dart';
import 'cover_image_picker/ui.dart';
import 'ingredient_field/state.dart';
import 'ingredient_field/ui.dart';
import 'name_field/ui.dart';
import 'open_form/state.dart';
import 'open_form/use_case.dart';
import 'preparation_time_field/ui.dart';
import 'save_changes/providers.dart';
import 'save_changes/ui/add_button.dart';
import 'save_changes/ui/edit_button.dart';
import 'state/cooking_step_field_list.dart';
import 'state/ingredient_field_list.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({Key? key}) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _titleStyle = TextStyle(
    fontSize: 28,
    color: Colors.grey.shade700,
  );

  @override
  Widget build(BuildContext context) {
    return wrapInForm([
      if (context.watch<EditedRecipe>().isNewRecipe)
        Padding(
          padding: paddingOf(vertical: 20),
          child: Text(
            'New recipe',
            style: _titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
      NameField(),
      SizedBox(height: 20),
      CoverImagePicker(),
      SizedBox(height: 20),
      buildIngredientFields(),
      SizedBox(height: 20),
      buildCookingStepFields(),
      SizedBox(height: 20),
      PreparationTimeField(),
      SizedBox(height: 40),
      buildButtons(),
    ]);
  }

  StreamSubscription? deleteRecipeHandler;
  @override
  void initState() {
    super.initState();

    final editedRecipe = context.read<EditedRecipe>();
    final deleteRecipeProgress$ = context.read<DeleteRecipeProgress$>();
    final deletedRecipeIDStream = deleteRecipeProgress$.recipeID$.stream;

    if (editedRecipe.maybeID.isSome()) {
      deleteRecipeHandler = deletedRecipeIDStream.listen((deletedID) {
        if (editedRecipe.maybeID == deletedID) {
          context.read<OpenRecipeFormUseCase>().emptyForm();
        }
      });
    }
  }

  @override
  void dispose() {
    deleteRecipeHandler?.cancel();
    super.dispose();
  }

  Widget wrapInForm(List<Widget> children) {
    return Form(
      key: Provider.of<GlobalKey<FormState>>(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget buildIngredientFields() {
    return BlocBuilder<IngredientFieldList$, List<IngredientField$>>(
      builder: (_, list) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < list.length; i++)
              Padding(
                padding: paddingOf(vertical: 10),
                child: MultiProvider(
                  key: ValueKey(list[i].hashCode),
                  providers: [
                    Provider<IngredientNumber>(
                      create: (_) => IngredientNumber.index(i),
                    ),
                    Provider<IngredientField$>(
                      create: (_) => list[i],
                    ),
                  ],
                  child: IngredientField(),
                ),
              ),
            OutlinedButton.icon(
              onPressed: context.watch<IngredientFieldList$>().addField,
              icon: Icon(Icons.add),
              label: Text('Add ingredient'),
            ),
          ],
        );
      },
    );
  }

  Widget buildCookingStepFields() {
    return BlocBuilder<CookingStepFieldList$, List<CookingStepField$>>(
      builder: (_, list) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < list.length; i++)
              Padding(
                padding: paddingOf(vertical: 10),
                child: MultiProvider(
                  key: ValueKey(list[i].hashCode),
                  providers: [
                    Provider<CookingStepNumber>(
                      create: (_) => CookingStepNumber.index(i),
                    ),
                    Provider<CookingStepField$>(
                      create: (_) => list[i],
                    ),
                  ],
                  child: CookingStepField(),
                ),
              ),
            OutlinedButton.icon(
              onPressed: context.watch<CookingStepFieldList$>().addField,
              icon: Icon(Icons.add),
              label: Text('Add step'),
            ),
          ],
        );
      },
    );
  }

  Widget buildButtons() {
    final editedRecipe = context.watch<EditedRecipe>();

    return editedRecipe.maybeID.fold(
      buildAddRecipeModeButtons,
      buildEditRecipeModeButtons,
    );
  }

  Widget buildAddRecipeModeButtons() {
    return Row(children: [
      Expanded(
        child: OutlinedButton(
          onPressed: context.read<OpenRecipeFormUseCase>().resetForm,
          child: Text('Reset'),
        ),
      ),
      SizedBox(width: 20),
      Expanded(
        child: MultiProvider(
          providers: createSaveChangesProviders(),
          child: AddRecipeButton(
            validate: validate,
          ),
        ),
      ),
    ]);
  }

  Widget buildEditRecipeModeButtons(String recipeID) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MultiProvider(
          providers: createSaveChangesProviders(),
          child: SaveChangesButton(
            recipeID: recipeID,
            validate: validate,
          ),
        ),
        SizedBox(height: 20),
        Row(children: [
          Expanded(
            child: OutlinedButton(
              onPressed: context.read<CloseRecipeForm>(),
              child: Text('Cancel'),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: OutlinedButton(
              onPressed: () =>
                  context.read<OpenRecipeFormUseCase>().resetForm(),
              child: Text('Reset'),
            ),
          ),
        ])
      ],
    );
  }

  bool validate() {
    final formKey = context.read<GlobalKey<FormState>>();

    return formKey.currentState!.validate();
  }
}
