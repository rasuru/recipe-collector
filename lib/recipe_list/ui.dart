import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/delete_recipe/use_case.dart';
import 'package:recipe_collector/progress.dart';
import 'package:recipe_collector/recipe_details/state.dart';
import 'package:recipe_collector/recipe_form/open_form/use_case.dart';
import 'package:recipe_collector/ui/padding.dart';
import 'package:recipe_collector/ui/theme.dart';
import 'package:recipe_collector/ui/widgets/no_image_sign.dart';

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
            onTap: () => context.read<ViewedRecipeID$>().set(recipe.id),
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
  static final borderRadius = BorderRadius.circular(10);
  static final decoration = BoxDecoration(
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
  );

  RecipeListTile({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCoverImage(),
            Padding(
              padding: paddingOf(all: 15),
              child: buildChips(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChips(BuildContext context) {
    final theme = context.read<UITheme>();

    final chips = [
      if (recipe.totalTime > Duration.zero)
        Chip(
          visualDensity: VisualDensity.compact,
          labelPadding: paddingOf(right: 4),
          backgroundColor: Colors.blue.shade100,
          avatar: Icon(theme.totalTimeIcon, size: 18),
          label: Text(prettyDuration(
            recipe.totalTime,
            abbreviated: true,
          )),
        ),
      if (recipe.preparationTime > Duration.zero)
        Chip(
          visualDensity: VisualDensity.compact,
          labelPadding: paddingOf(right: 4),
          backgroundColor: Colors.blue.shade50,
          avatar: Icon(theme.preparationTimeIcon, size: 18),
          label: Text(prettyDuration(
            recipe.preparationTime,
            abbreviated: true,
          )),
        ),
      if (recipe.cookingTime > Duration.zero)
        Chip(
          visualDensity: VisualDensity.compact,
          labelPadding: paddingOf(right: 4),
          backgroundColor: Colors.blue.shade50,
          avatar: Icon(theme.cookingTimeIcon, size: 18),
          label: Text(prettyDuration(
            recipe.cookingTime,
            abbreviated: true,
          )),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildTitle(),
        SizedBox(height: 5),
        Wrap(spacing: 5, runSpacing: 5, children: chips),
      ],
    );
  }

  Widget buildCoverImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: recipe.optionalCoverImage.fold(
        buildNoImageSign,
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
