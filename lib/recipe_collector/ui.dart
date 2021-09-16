import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/recipe_form/add_recipe/providers.dart';
import 'package:recipe_collector/recipe_form/add_recipe/widgets/button.dart';
import 'package:recipe_collector/ui/theme.dart';

class RecipeCollectorUI extends StatelessWidget {
  RecipeCollectorUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: MultiProvider(
            providers: [
              Provider<UITheme>(create: (_) => UITheme()),
              ...createAddRecipeProviders(),
            ],
            child: Center(
              child: AddRecipeButton(),
            ),
          ),
        ),
      ),
    );
  }
}
