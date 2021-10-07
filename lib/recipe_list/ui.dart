import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/delete_recipe/use_case.dart';
import 'package:recipe_collector/progress.dart';
import 'package:recipe_collector/recipe_details/state.dart';
import 'package:recipe_collector/recipe_form/open_form/use_case.dart';
import 'package:recipe_collector/ui/padding.dart';

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
    return Builder(builder: (context) {
      return ListView(
        padding: paddingOf(vertical: 20),
        children: recipes.map((recipe) {
          return InkWell(
            onLongPress: () => showActions(context, recipe),
            onTap: () => context.read<ViewedRecipe$>().set(recipe.id),
            child: Padding(
              padding: paddingOf(all: 20),
              child: RecipeListTile(recipe: recipe),
            ),
          );
        }).toList(),
      );
    });
  }

  void showActions(BuildContext context, Recipe recipe) {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: buildActions(context, recipe),
          ),
        );
      },
    );
  }

  List<Widget> buildActions(BuildContext context, Recipe recipe) {
    return [
      ListTile(
        title: Text('Edit'),
        onTap: () {
          context.read<OpenRecipeFormUseCase>()(recipe.id);
          Navigator.of(context).pop();
        },
      ),
      ListTile(
        title: Text('Delete'),
        onTap: () {
          context.read<DeleteRecipeUseCase>()(recipe.id);
          Navigator.of(context).pop();
        },
      ),
    ];
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
    final borderRadius = BorderRadius.circular(10);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 16,
            color: Colors.black12,
          ),
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 2,
            color: Colors.black12,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCoverImage(),
            Padding(
              padding: paddingOf(all: 15),
              child: buildTitle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCoverImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: recipe.optionalCoverImage.fold(
        () => Container(
          alignment: Alignment.center,
          color: Colors.grey.shade200,
          child: Icon(
            Icons.local_dining,
            size: 80,
            color: Colors.grey.shade400,
          ),
        ),
        (image) => Image.memory(image, fit: BoxFit.cover),
      ),
    );
  }

  Widget buildTitle() {
    final textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
      color: Colors.grey.shade900,
    );

    return Text(recipe.name, style: textStyle);
  }
}
