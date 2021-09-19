import 'package:provider/provider.dart';

import '../open_form/use_case.dart';
import 'controller.dart';
import 'state.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createSaveChangesProviders() {
  return [
    Provider<SaveChangesProgress$>(create: (_) => SaveChangesProgress$()),
    Provider<SaveChangesController>(
      create: (context) => SaveChangesController(
        SaveChangesUseCase(
          present: context.read<SaveChangesProgress$>(),
          update: updateRecipe,
          openRecipeForm: context.read<OpenRecipeFormUseCase>(),
        ),
      ),
    ),
  ];
}
