import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class CookingTime$ extends Cubit<Option<Duration>> {
  CookingTime$(Option<Duration> initial) : super(initial);

  void present(Duration duration) {
    if (duration.inMinutes == 0) {
      emit(None());
    } else {
      emit(Some(duration));
    }
  }
}
