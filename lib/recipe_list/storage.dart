import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:recipe_collector/database.dart';
import 'package:recipe_collector/extensions/sqlbrite.dart';

import 'domain.dart';

Stream<Future<List<Recipe>>> queryRecipes() {
  return db.createQuery(RecipeTable.name).asyncMapRows((row) async {
    final id = row[RecipeTable.columns.id] as String;
    final coverImage = row[RecipeTable.columns.coverImage] as Uint8List?;

    return Recipe(
      id: id,
      name: row[RecipeTable.columns.name] as String,
      optionalCoverImage: optionOf(coverImage),
    );
  });
}
