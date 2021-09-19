import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/delete_recipe/state.dart';

import 'add_recipe/providers.dart';
import 'add_recipe/ui.dart';
import 'domain.dart';
import 'name_field/ui.dart';
import 'open_form/use_case.dart';
import 'reset_form/ui.dart';
import 'save_changes/ui.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({Key? key}) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleStyle = TextStyle(
    fontSize: 28,
    color: Colors.grey.shade700,
  );

  @override
  Widget build(BuildContext context) {
    return wrapInForm([
      if (context.watch<EditedRecipe>().isNewRecipe)
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'New recipe',
            style: _titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
      NameField(),
      SizedBox(height: 20),
      Row(children: [
        Expanded(child: ResetFormButton(formKey: _formKey)),
        SizedBox(width: 20),
        Expanded(
          child: buildSumbitButton(context),
        ),
      ]),
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
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget buildSumbitButton(BuildContext context) {
    final editedRecipe = context.watch<EditedRecipe>();

    return editedRecipe.maybeID.fold(
      () {
        return MultiProvider(
          providers: createAddRecipeProviders(),
          child: AddRecipeButton(
            validate: () {
              return _formKey.currentState!.validate();
            },
          ),
        );
      },
      (recipeID) {
        return MultiProvider(
          providers: createAddRecipeProviders(),
          child: EditRecipeButton(
            recipeID: recipeID,
            validate: () {
              return _formKey.currentState!.validate();
            },
          ),
        );
      },
    );
  }
}
