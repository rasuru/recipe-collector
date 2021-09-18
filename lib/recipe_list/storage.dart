import 'package:recipe_collector/extensions/sqlbrite.dart';

import '../../database.dart';
import 'domain.dart';

Stream<Future<List<Recipe>>> queryRecipes() {
  return db.createQuery(RecipeTable.name).mapRows((row) {
    return Recipe(
      id: row['id'] as String,
      name: row['name'] as String,
    );
  });
}
