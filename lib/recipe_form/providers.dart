import 'package:provider/provider.dart';

import 'name_field/state.dart';

List<Provider> createRecipeFormProviders() {
  return [
    Provider<Name$>(create: (_) => Name$()),
  ];
}
