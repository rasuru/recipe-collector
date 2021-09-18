import '../../database.dart';
import 'domain.dart';

Stream<Future<List<Recipe>>> queryRecipes() {
  return db.createQuery(RecipeTable.name).map((loadingRows) async {
    final rows = await loadingRows();

    return rows.map((row) {
      return Recipe(
        id: row['id'] as String,
        name: row['name'] as String,
      );
    }).toList();
  });
}
