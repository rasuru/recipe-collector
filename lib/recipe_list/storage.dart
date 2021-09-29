import 'package:recipe_collector/database.dart';
import 'package:recipe_collector/extensions/sqlbrite.dart';

import 'domain.dart';

Stream<Future<List<Recipe>>> queryRecipes() {
  return db.createQuery(RecipeTable.name).asyncMapRows((row) async {
    final id = row['id'] as String;

    return Recipe(
      id: id,
      name: row['name'] as String,
    );
  });
}
