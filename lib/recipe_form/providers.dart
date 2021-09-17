import 'package:provider/provider.dart';

import 'models/name.dart';

List<Provider> createRecipeFormProviders() {
  return [
    Provider<RecipeName$>(create: (_) => RecipeName$()),
  ];
}
