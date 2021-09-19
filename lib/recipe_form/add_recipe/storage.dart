import 'package:recipe_collector/database.dart';
import 'package:sqlbrite/sqlbrite.dart';

Future<void> insertRecipe({
  required String id,
  required String name,
}) async {
  await db.insert(
    RecipeTable.name,
    {
      RecipeTable.columns.id: id,
      RecipeTable.columns.name: name,
    },
    conflictAlgorithm: ConflictAlgorithm.rollback,
  );
}
