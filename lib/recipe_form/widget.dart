import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_recipe/providers.dart';
import 'add_recipe/widgets/button.dart';
import 'name_field/widget.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({Key? key}) : super(key: key);

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: MultiProvider(
        providers: [
          ...createAddRecipeProviders(),
        ],
        child: Column(
          children: [
            NameField(),
            SizedBox(height: 20),
            AddRecipeButton(
              validate: () {
                return _formKey.currentState!.validate();
              },
            ),
          ],
        ),
      ),
    );
  }
}
