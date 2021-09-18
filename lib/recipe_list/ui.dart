import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_collector/progress.dart';
import 'package:recipe_collector/recipe_list/controller.dart';

import 'domain.dart';
import 'state.dart';

class RecipeListView extends StatelessWidget {
  RecipeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeList$, Progress<List<Recipe>>>(
      builder: (context, progress) {
        return progress.fold(
          ifIdle: () {
            context.watch<ViewRecipeListController>()();
            return Container();
          },
          ifActive: () => Center(child: CircularProgressIndicator()),
          ifCompleted: buildRecipeListView,
          ifFailed: (error) => Center(child: Text('$error')),
        );
      },
    );
  }

  Widget buildRecipeListView(List<Recipe> recipes) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20),
      children: recipes.map((recipe) {
        return ListTile(
          title: Text(recipe.name),
        );
      }).toList(),
    );
  }
}
