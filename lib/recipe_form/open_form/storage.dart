import 'package:dartz/dartz.dart';
import 'package:recipe_collector/database.dart';

import '../domain.dart';

Future<EditedRecipe> queryRecipe(String id) async {
  final row = (await db.query(
    RecipeTable.name,
    where: 'id = ?',
    whereArgs: [id],
  ))[0];

  return EditedRecipe(
    maybeID: Some(row['id'] as String),
    name: row['name'] as String,
  );
}
