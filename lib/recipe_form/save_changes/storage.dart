import 'package:recipe_collector/database.dart';
import 'package:sqlbrite/sqlbrite.dart';

import 'domain.dart';

Future<void> insertRecipe(Recipe recipe) async {
  await db.transaction((t) async {
    await t.insert(RecipeTable.name, recipe.toSQL(includeID: true));
    await t.insertIngredientsOf(recipe);
    await t.insertCookingStepsOf(recipe);
  });
  db.sendTableTrigger([RecipeTable.name, IngredientTable.name]);
}

Future<void> updateRecipe(Recipe recipe) async {
  await db.transaction((t) async {
    await t.update(
      RecipeTable.name,
      recipe.toSQL(),
      where: '${RecipeTable.columns.id} = ?',
      whereArgs: [recipe.id],
    );
    await t.insertIngredientsOf(recipe);
    await t.insertCookingStepsOf(recipe);
  });
  db.sendTableTrigger([RecipeTable.name, IngredientTable.name]);
}

extension on Recipe {
  Map<String, Object?> toSQL({bool includeID = false}) {
    return {
      if (includeID) RecipeTable.columns.id: id,
      RecipeTable.columns.name: name,
      RecipeTable.columns.coverImage: optionalCoverImage.toNullable(),
      RecipeTable.columns.preparationTime: preparationTime.toSQL(),
      RecipeTable.columns.cookingTime: cookingTime.toSQL(),
      RecipeTable.columns.totalTime: totalTime.toSQL(),
    };
  }
}

extension on DatabaseExecutor {
  Future<void> insertIngredientsOf(Recipe recipe) async {
    await delete(
      IngredientTable.name,
      where: '${IngredientTable.columns.recipeID} = ?',
      whereArgs: [recipe.id],
    );

    for (final ingredient in recipe.ingredients) {
      await insert(
        IngredientTable.name,
        {
          IngredientTable.columns.recipeID: recipe.id,
          IngredientTable.columns.name: ingredient.name,
          IngredientTable.columns.amount: ingredient.amount,
        },
      );
    }
  }

  Future<void> insertCookingStepsOf(Recipe recipe) async {
    await delete(
      CookingStepTable.name,
      where: '${CookingStepTable.columns.recipeID} = ?',
      whereArgs: [recipe.id],
    );

    for (int i = 0; i < recipe.cookingSteps.length; i++) {
      final step = recipe.cookingSteps[i];

      await insert(
        CookingStepTable.name,
        {
          CookingStepTable.columns.recipeID: recipe.id,
          CookingStepTable.columns.id: i,
          CookingStepTable.columns.text: step,
        },
      );
    }
  }
}
