import 'package:provider/provider.dart';

import 'state.dart';

List<Provider> createPreparationTimeFieldProviders() {
  return [
    Provider<PreparationTime$>(create: (_) => PreparationTime$()),
  ];
}
