import 'package:dartz/dartz.dart';
import 'package:provider/provider.dart';

import '../cooking_time_field/state.dart';
import '../preparation_time_field/state.dart';
import 'state.dart';

List<Provider> createTotalTimeFieldProviders(Option<Duration> initial) {
  return [
    Provider<TotalTime$>(
      create: (context) => TotalTime$(
        initial: initial,
        preparationTime$: context.read<PreparationTime$>(),
        cookingTime$: context.read<CookingTime$>(),
      ),
    ),
  ];
}
