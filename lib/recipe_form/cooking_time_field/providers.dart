import 'package:dartz/dartz.dart';
import 'package:provider/provider.dart';

import 'state.dart';

List<Provider> createCookingTimeFieldProviders(Option<Duration> initial) {
  return [
    Provider<CookingTime$>(create: (_) => CookingTime$(initial)),
  ];
}
