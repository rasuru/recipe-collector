import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:recipe_collector/database.dart';

import '../domain.dart';

Future<EditedRecipe> queryRecipe(String id) async {
  final columns = RecipeTable.columns;
  final row = (await db.query(
    RecipeTable.name,
    where: '${columns.id} = ?',
    whereArgs: [id],
  ))[0];

  return EditedRecipe(
    maybeID: Some(id),
    name: row[columns.name] as String,
    optionalCoverImage: optionOf(row[columns.coverImage] as Uint8List?),
    ingredients: await queryIngredients(id),
    cookingSteps: await queryCookingSteps(id),
    preparationTime: sqlToDuration(row[columns.preparationTime]),
    cookingTime: sqlToDuration(row[columns.cookingTime]),
    totalTime: sqlToDuration(row[columns.totalTime]),
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
