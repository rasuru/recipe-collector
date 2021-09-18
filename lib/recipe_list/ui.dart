import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/delete_recipe/providers.dart';
import 'package:recipe_collector/delete_recipe/use_case.dart';
import 'package:recipe_collector/progress.dart';
import 'controller.dart';

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
        return RecipeListTile(recipe: recipe);
      }).toList(),
    );
  }
}

class RecipeListTile extends StatelessWidget {
  final Recipe recipe;

  RecipeListTile({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => showActions(context),
      title: Text(recipe.name),
    );
  }

  void showActions(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: buildActions(),
          ),
        );
      },
    );
  }

  List<Widget> buildActions() {
    return [
      MultiProvider(
        providers: createDeleteRecipeProviders(),
        builder: (context, _) {
          return ListTile(
            title: Text('Delete'),
            onTap: () {
              context.read<DeleteRecipeUseCase>()(recipe.id);
              Navigator.of(context).pop();
            },
          );
        },
      ),
    ];
  }
}
