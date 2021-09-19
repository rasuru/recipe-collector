import 'package:recipe_collector/database.dart';
import 'package:sqlbrite/sqlbrite.dart';

Future<void> updateRecipe({
  required String id,
  required String? name,
}) async {
  await db.update(
    RecipeTable.name,
    {
      if (name != null) RecipeTable.columns.name: name,
    },
    where: 'id = ?',
    whereArgs: [id],
    conflictAlgorithm: ConflictAlgorithm.rollback,
  );
}
