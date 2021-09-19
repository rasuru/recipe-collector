import 'package:provider/provider.dart';

import 'delete_recipe/providers.dart';
import 'recipe_form/open_form/providers.dart';
import 'ui/theme.dart';

List<Provider> createGlobalProviders() {
  return [
    Provider<UITheme>(create: (_) => UITheme()),
    ...createOpenFormProviders(),
    ...createDeleteRecipeProviders(),
  ];
}
