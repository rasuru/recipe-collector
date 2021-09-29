import 'package:dartz/dartz.dart';
import 'package:recipe_collector/database.dart';

import '../domain.dart';

Future<EditedRecipe> queryRecipe(String id) async {
  final row = (await db.query(
    RecipeTable.name,
    where: '${RecipeTableColumns().id} = ?',
    whereArgs: [id],
  ))[0];
  final ingredients = await queryIngredients(id);

  return EditedRecipe(
    maybeID: Some(id),
    name: row['name'] as String,
    ingredients: ingredients,
  );
}

Future<List<EditedIngredient>> queryIngredients(String recipeID) async {
  final rows = await db.query(
    IngredientTable.name,
    where: '${IngredientTableColumns().recipeID} = ?',
    whereArgs: [recipeID],
  );

  return rows.map((row) {
    return EditedIngredient(
      name: row['name'] as String,
      amount: row['amount'] as String?,
    );
  }).toList();
}
