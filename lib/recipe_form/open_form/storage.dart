import 'package:dartz/dartz.dart';
import 'package:recipe_collector/database.dart';

import '../domain.dart';

Future<EditedRecipe> queryRecipe(String id) async {
  final row = (await db.query(
    RecipeTable.name,
    where: '${RecipeTable.columns.id} = ?',
    whereArgs: [id],
  ))[0];
  final ingredients = await queryIngredients(id);
  final cookingSteps = await queryCookingSteps(id);

  return EditedRecipe(
    maybeID: Some(id),
    name: row['name'] as String,
    ingredients: ingredients,
    cookingSteps: cookingSteps,
  );
}

Future<List<EditedIngredient>> queryIngredients(String recipeID) async {
  final rows = await db.query(
    IngredientTable.name,
    where: '${IngredientTable.columns.recipeID} = ?',
    whereArgs: [recipeID],
  );

  return rows.map((row) {
    return EditedIngredient(
      name: row[IngredientTable.columns.name] as String,
      amount: row[IngredientTable.columns.amount] as String?,
    );
  }).toList();
}

Future<List<String>> queryCookingSteps(String recipeID) async {
  final rows = await db.query(
    CookingStepTable.name,
    where: '${CookingStepTable.columns.recipeID} = ?',
    whereArgs: [recipeID],
  );

  return rows
      .map((row) => row[CookingStepTable.columns.text] as String)
      .toList();
}
