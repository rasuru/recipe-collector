import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class PreparationTime$ extends Cubit<Option<Duration>> {
  PreparationTime$() : super(None());

  void present(Duration duration) {
    if (duration.inMinutes == 0) {
      emit(None());
    } else {
      emit(Some(duration));
    }
  }
}
