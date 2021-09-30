import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'delete_recipe/providers.dart';
import 'recipe_form/open_form/providers.dart';
import 'recipe_form/save_changes/state.dart';
import 'ui/theme.dart';

List<Provider> createGlobalProviders() {
  return [
    Provider<SheetController>(create: (_) => SheetController()),
    Provider<UITheme>(create: (_) => UITheme()),
    Provider<SaveChangesProgress$>(create: (_) => SaveChangesProgress$()),
    ...createOpenFormProviders(),
    ...createDeleteRecipeProviders(),
  ];
}
