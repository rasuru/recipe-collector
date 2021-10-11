import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../preparation_time_field/state.dart';
import '../cooking_time_field/state.dart';

class TotalTime$ extends Cubit<Option<Duration>> {
  final PreparationTime$ preparationTime$;
  final CookingTime$ cookingTime$;
  late final StreamSubscription _preparationTimeSubscription;
  late final StreamSubscription _cookingTimeSubscription;

  TotalTime$({
    required Option<Duration> initial,
    required this.preparationTime$,
    required this.cookingTime$,
  }) : super(initial) {
    _preparationTimeSubscription =
        preparationTime$.stream.listen((_) => recalculate());
    _cookingTimeSubscription = cookingTime$.stream.listen((_) => recalculate());
  }

  void recalculate() {
    final preparationTime = preparationTime$.state | Duration.zero;
    final cookingTime = cookingTime$.state | Duration.zero;

    present(preparationTime + cookingTime);
  }

  void present(Duration duration) {
    if (duration.inMinutes == 0) {
      emit(None());
    } else {
      emit(Some(duration));
    }
  }

  @override
  Future<void> close() async {
    await _preparationTimeSubscription.cancel();
    await _cookingTimeSubscription.cancel();
    await super.close();
  }
}
