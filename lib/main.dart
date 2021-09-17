import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database.dart';
import 'recipe_collector/ui.dart';
import 'ui/theme.dart';

void main() async {
  await setupDatabase();
  runApp(Provider<UITheme>(
    create: (_) => UITheme(),
    child: RecipeCollectorUI(),
  ));
}
