import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:recipe_collector/database.dart';
import 'package:recipe_collector/extensions/sqlbrite.dart';

import 'domain.dart';

Stream<Future<List<Recipe>>> queryRecipes() {
  return db.createQuery(RecipeTable.name).asyncMapRows((row) async {
    final columns = RecipeTable.columns;
    final coverImage = row[columns.coverImage] as Uint8List?;

    return Recipe(
      id: row[columns.id] as String,
      name: row[columns.name] as String,
      optionalCoverImage: optionOf(coverImage),
      preparationTime: sqlToDuration(row[columns.preparationTime]),
      cookingTime: sqlToDuration(row[columns.cookingTime]),
      totalTime: sqlToDuration(row[columns.totalTime]),
    );
  });
}
