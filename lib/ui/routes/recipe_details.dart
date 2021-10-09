import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/progress.dart';
import 'package:recipe_collector/recipe_details/domain.dart';
import 'package:recipe_collector/recipe_details/providers.dart';
import 'package:recipe_collector/recipe_details/state.dart';
import 'package:recipe_collector/recipe_details/ui.dart';
import 'package:recipe_collector/recipe_details/use_case.dart';

import '../toast_overlay.dart';

class RecipeDetailsRoute {
  static const key = ValueKey('recipe-details');

  static MaterialPage build(String id) {
    return MaterialPage(
      key: key,
      child: Scaffold(
        body: SafeArea(
          child: ToastOverlay(
            MultiProvider(
              providers: createRecipeDetailsProviders(),
              child: _RecipeDetailsWrapper(id),
            ),
          ),
        ),
      ),
    );
  }
}

class _RecipeDetailsWrapper extends StatefulWidget {
  final String recipeID;

  _RecipeDetailsWrapper(this.recipeID);

  @override
  State<_RecipeDetailsWrapper> createState() => _RecipeDetailsWrapperState();
}

class _RecipeDetailsWrapperState extends State<_RecipeDetailsWrapper> {
  @override
  void initState() {
    super.initState();
    context.read<ViewRecipeUseCase>()(widget.recipeID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewRecipeProgress$, Progress<Recipe>>(
      builder: (_, progress) {
        return progress.fold(
          ifIdle: () => Container(),
          ifActive: () => Container(),
          ifFailed: (error) => Center(child: Text('$error')),
          ifCompleted: (recipe) => RecipeDetails(recipe),
        );
      },
    );
  }
}
