import 'package:bloc/bloc.dart';
import 'package:recipe_collector/progress.dart';

class DeleteRecipeProgress$ extends Cubit<Progress> {
  DeleteRecipeProgress$() : super(Idle());

  void call(Progress progress) {
    emit(progress);
  }
}
