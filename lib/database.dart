import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:path/path.dart' as path;

late final BriteDatabase db;

Future<void> setupDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databasesDir = await getDatabasesPath();
  await ensurePathExists(databasesDir);
  db = BriteDatabase(await openDatabase(
    path.join(databasesDir, 'recipes.db'),
    version: 3,
    onCreate: createDatabase,
  ));
}

Future ensurePathExists(String path) async {
  try {
    await Directory(path).create(recursive: true);
  } catch (_) {}
}

Future<void> createDatabase(Database db, int version) async {
  await db.execute('PRAGMA foreign_keys = ON;');
  await db.execute(RecipeTable.scheme);
  await db.execute(IngredientTable.scheme);
}

class RecipeTable {
  static final name = 'recipes';
  static final columns = RecipeTableColumns();
  static final scheme = '''
CREATE TABLE ${name} (
  ${columns.id} TEXT PRIMARY KEY,
  ${columns.name} TEXT
);''';
}

class RecipeTableColumns {
  final id = 'id';
  final name = 'name';
}

class IngredientTable {
  static final name = 'ingredients';
  static final columns = IngredientTableColumns();
  static final scheme = '''
CREATE TABLE ${name} (
  ${columns.recipeID} TEXT
                      REFERENCES ${RecipeTable.name}(${RecipeTableColumns().id})
                      ON DELETE CASCADE,
  ${columns.name} TEXT,
  ${columns.amount} TEXT,
  PRIMARY KEY (${columns.recipeID}, ${columns.name})
);''';
}

class IngredientTableColumns {
  final recipeID = 'recipe_id';
  final name = 'name';
  final amount = 'amount';
}
