import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class CookingTime$ extends Cubit<Option<Duration>> {
  CookingTime$() : super(None());

  void present(Duration duration) {
    if (duration.inMinutes == 0) {
      emit(None());
    } else {
      emit(Some(duration));
    }
  }
}
