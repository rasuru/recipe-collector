import 'dart:typed_data';

import 'package:recipe_collector/extensions/option.dart';
import 'package:recipe_collector/ui/padding.dart';
import 'package:recipe_collector/ui/widgets/list_tile_icon.dart';

import 'domain.dart';
import 'package:flutter/material.dart';

const horizontalPadding = 30.0;
const groupHorizontalPadding = 10.0;

class RecipeDetails extends StatelessWidget {
  final Recipe recipe;

  RecipeDetails(this.recipe);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        if (recipe.optionalCoverImage.isSome())
          buildCoverImage(recipe.optionalCoverImage.value),
        const SizedBox(height: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTitle(recipe.name),
            const SizedBox(height: 40),
            buildSectionTitle('Ingredients'),
            ...buildIngredientList(),
            const SizedBox(height: 20),
            buildSectionTitle('Cooking'),
            buildCookingSteps(),
          ],
        ),
      ]),
    );
  }

  Widget buildCoverImage(Uint8List image) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Image.memory(image, fit: BoxFit.cover),
    );
  }

  Widget buildTitle(String title) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: Colors.grey.shade900,
    );

    return Padding(
      padding: paddingOf(horizontal: horizontalPadding),
      child: Text(title, style: textStyle),
    );
  }

  Widget buildSectionTitle(String title) {
    final textStyle = TextStyle(
      color: Colors.grey.shade600,
      fontSize: 16,
    );

    return Padding(
      padding: paddingOf(horizontal: horizontalPadding, bottom: 10),
      child: Text(title, style: textStyle),
    );
  }

  Iterable<Widget> buildIngredientList() {
    return recipe.ingredients.map((ingredient) {
      return Padding(
        padding: paddingOf(
          left: groupHorizontalPadding,
          right: horizontalPadding,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: buildBulletPoint(),
          title: Text(ingredient.name),
          trailing: ingredient.amount == null
              ? null
              : Text(
                  ingredient.amount!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
        ),
      );
    });
  }

  Widget buildCookingSteps() {
    return Padding(
      padding: paddingOf(
        left: groupHorizontalPadding,
        right: horizontalPadding,
      ),
      child: Stepper(
        controlsBuilder: (_, {onStepCancel, onStepContinue}) => Container(),
        currentStep: recipe.cookingSteps.length - 1,
        physics: const NeverScrollableScrollPhysics(),
        steps: recipe.cookingSteps.map(buildCookingStep).toList(),
      ),
    );
  }

  Step buildCookingStep(String cookingStep) {
    return Step(
      title: Text(cookingStep),
      content: Container(),
      isActive: true,
      state: StepState.indexed,
    );
  }
}
