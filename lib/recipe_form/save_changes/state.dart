import 'package:bloc/bloc.dart';
import 'package:recipe_collector/progress.dart';

class SaveChangesProgress$ extends Cubit<Progress> {
  SaveChangesProgress$() : super(Idle());

  void call(Progress progress) {
    emit(progress);
  }
}
