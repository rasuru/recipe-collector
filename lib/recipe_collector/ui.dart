import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/recipe_form/providers.dart';
import 'package:recipe_collector/recipe_form/widget.dart';
import 'package:recipe_collector/ui/theme.dart';

class RecipeCollectorUI extends StatelessWidget {
  RecipeCollectorUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UITheme>(create: (_) => UITheme()),
        ...createRecipeFormProviders(),
      ],
      builder: (context, _) {
        return MaterialApp(
          themeMode: ThemeMode.light,
          theme: context.read<UITheme>().flutterTheme,
          home: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: RecipeForm(),
              ),
            ),
          ),
        );
      },
    );
  }
}
