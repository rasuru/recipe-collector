import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_recipe/providers.dart';
import 'add_recipe/ui.dart';
import 'name_field/ui.dart';

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
    return Form(
      key: _formKey,
      child: MultiProvider(
        providers: [
          ...createAddRecipeProviders(),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'New recipe',
              style: _titleStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
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