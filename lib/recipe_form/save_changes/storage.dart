import 'package:recipe_collector/database.dart';

import 'domain.dart';

Future<void> insertRecipe({
  required String id,
  required String name,
  required List<Ingredient> ingredients,
}) async {
  await db.transaction((t) async {
    await t.insert(
      RecipeTable.name,
      {
        RecipeTable.columns.id: id,
        RecipeTable.columns.name: name,
      },
    );

    for (final ingredient in ingredients) {
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

Future<void> updateRecipe({
  required String id,
  required String? name,
  required List<Ingredient> ingredients,
}) async {
  await db.transaction((t) async {
    await t.update(
      RecipeTable.name,
      {
        if (name != null) RecipeTable.columns.name: name,
      },
      where: '${RecipeTableColumns().id} = ?',
      whereArgs: [id],
    );

    await t.delete(
      IngredientTable.name,
      where: '${IngredientTableColumns().recipeID} = ?',
      whereArgs: [id],
    );

    for (final ingredient in ingredients) {
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
