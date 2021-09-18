import 'package:provider/provider.dart';

import 'state/name.dart';

List<Provider> createRecipeFormProviders() {
  return [
    Provider<RecipeName$>(create: (_) => RecipeName$()),
  ];
}
