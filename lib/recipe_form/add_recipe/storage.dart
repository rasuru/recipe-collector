import 'package:recipe_collector/database.dart';
import 'package:sqlbrite/sqlbrite.dart';

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
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );

    for (final ingredient in ingredients) {
      await t.insert(
        IngredientTable.name,
        {
          IngredientTable.columns.recipeID: id,
          IngredientTable.columns.name: ingredient.name,
          IngredientTable.columns.amount: ingredient.amount,
        },
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );
    }
  });
}
