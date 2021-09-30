import 'package:provider/provider.dart';

import 'controller.dart';
import 'state.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createSaveChangesProviders() {
  return [
    Provider<SaveChanges>(
      create: (context) => SaveChanges(
        SaveChangesUseCase(
          present: context.read<SaveChangesProgress$>(),
          store: insertRecipe,
          update: updateRecipe,
        ),
      ),
    ),
  ];
}
