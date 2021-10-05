import 'package:recipe_collector/database.dart';

import 'domain.dart';

Future<void> insertRecipe(String id, NewRecipe recipe) async {
  await db.transaction((t) async {
    await t.insert(
      RecipeTable.name,
      {
        RecipeTable.columns.id: id,
        RecipeTable.columns.name: recipe.name,
        RecipeTable.columns.coverImage: recipe.optionalCoverImage.toNullable(),
      },
    );

    for (final ingredient in recipe.ingredients) {
      await t.insert(
        IngredientTable.name,
        {
          IngredientTable.columns.recipeID: id,
          IngredientTable.columns.name: ingredient.name,
          IngredientTable.columns.amount: ingredient.amount,
        },
      );
    }

    for (int i = 0; i < recipe.cookingSteps.length; i++) {
      final step = recipe.cookingSteps[i];

      await t.insert(
        CookingStepTable.name,
        {
          CookingStepTable.columns.recipeID: id,
          CookingStepTable.columns.id: i,
          CookingStepTable.columns.text: step,
        },
      );
    }
  });
  db.sendTableTrigger([RecipeTable.name, IngredientTable.name]);
}

Future<void> updateRecipe(String id, NewRecipe recipe) async {
  await db.transaction((t) async {
    await t.update(
      RecipeTable.name,
      {
        RecipeTable.columns.name: recipe.name,
        RecipeTable.columns.coverImage: recipe.optionalCoverImage.toNullable(),
      },
      where: '${RecipeTable.columns.id} = ?',
      whereArgs: [id],
    );

    await t.delete(
      IngredientTable.name,
      where: '${IngredientTable.columns.recipeID} = ?',
      whereArgs: [id],
    );

    for (final ingredient in recipe.ingredients) {
      await t.insert(
        IngredientTable.name,
        {
          IngredientTable.columns.recipeID: id,
          IngredientTable.columns.name: ingredient.name,
          IngredientTable.columns.amount: ingredient.amount,
        },
      );
    }
  });
  db.sendTableTrigger([RecipeTable.name, IngredientTable.name]);
}
