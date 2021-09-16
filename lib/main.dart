import 'package:flutter/material.dart';

import 'database.dart';
import 'recipe_collector/ui.dart';

void main() async {
  await setupDatabase();
  runApp(RecipeCollectorUI());
}
