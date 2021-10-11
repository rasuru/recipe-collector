import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:recipe_collector/database.dart';
import 'package:recipe_collector/extensions/sqlbrite.dart';

import 'domain.dart';

Stream<Future<List<Recipe>>> queryRecipes() {
  return db.createQuery(RecipeTable.name).asyncMapRows((row) async {
    final columns = RecipeTable.columns;
    final id = row[columns.id] as String;
    final coverImage = row[columns.coverImage] as Uint8List?;
    final preparationTime = sqlToDuration(row[columns.preparationTime]);
    final cookingTime = sqlToDuration(row[columns.cookingTime]);

    return Recipe(
      id: id,
      name: row[columns.name] as String,
      optionalCoverImage: optionOf(coverImage),
      preparationTime: preparationTime,
      cookingTime: cookingTime,
    );
  });
}
