import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database.dart';
import 'providers.dart';
import 'ui.dart';

void main() async {
  await setupDatabase();
  runApp(MultiProvider(
    providers: createGlobalProviders(),
    child: RecipeCollectorUI(),
  ));
}
