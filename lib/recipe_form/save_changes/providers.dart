import 'package:provider/provider.dart';

import 'controller.dart';
import 'state.dart';
import 'storage.dart';
import 'use_case.dart';

List<Provider> createSaveChangesProviders() {
  return [
    Provider<SaveChangesProgress$>(create: (_) => SaveChangesProgress$()),
    Provider<SaveChanges>(
      create: (context) => SaveChanges(
        SaveChangesUseCase(
          present: context.read<SaveChangesProgress$>(),
          update: updateRecipe,
        ),
      ),
    ),
  ];
}
