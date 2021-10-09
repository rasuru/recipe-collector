import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:recipe_collector/database.dart';

import 'domain.dart';

Future<Recipe> queryRecipe(String id) async {
  final row = (await db.query(
    RecipeTable.name,
    where: '${RecipeTable.columns.id} = ?',
    whereArgs: [id],
  ))[0];
  final coverImage = row[RecipeTable.columns.coverImage] as Uint8List?;
  final ingredients = await queryIngredients(id);
  final cookingSteps = await queryCookingSteps(id);

  return Recipe(
    id: id,
    name: row[RecipeTable.columns.name] as String,
    optionalCoverImage: optionOf(coverImage),
    ingredients: ingredients,
    cookingSteps: cookingSteps,
  );
}

Future<List<Ingredient>> queryIngredients(String recipeID) async {
  final rows = await db.query(
    IngredientTable.name,
    where: '${IngredientTable.columns.recipeID} = ?',
    whereArgs: [recipeID],
  );

  return rows.map((row) {
    return Ingredient(
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
