import 'package:bloc/bloc.dart';
import 'package:recipe_collector/progress.dart';

class AddRecipeProgress$ extends Cubit<Progress> {
  AddRecipeProgress$() : super(Idle());

  void call(Progress progress) {
    emit(progress);
  }
}
