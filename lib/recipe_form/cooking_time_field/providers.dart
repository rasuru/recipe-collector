import 'package:provider/provider.dart';

import 'state.dart';

List<Provider> createCookingTimeFieldProviders() {
  return [
    Provider<CookingTime$>(create: (_) => CookingTime$()),
  ];
}
