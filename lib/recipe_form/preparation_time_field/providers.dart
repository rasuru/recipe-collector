import 'package:dartz/dartz.dart';
import 'package:provider/provider.dart';

import 'state.dart';

List<Provider> createPreparationTimeFieldProviders(Option<Duration> initial) {
  return [
    Provider<PreparationTime$>(create: (_) => PreparationTime$(initial)),
  ];
}
