import 'package:recipe_collector/database.dart';

Future<void> deleteRecipe(String id) async {
  await db.delete(
    RecipeTable.name,
    where: 'id = ?',
    whereArgs: [id],
  );
}
