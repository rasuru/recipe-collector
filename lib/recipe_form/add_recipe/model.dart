import 'package:bloc/bloc.dart';
import 'package:recipe_collector/progress.dart';

import 'controller.dart';
import 'use_case.dart';

class AddRecipeProgress$ extends Cubit<Progress<AddRecipeController>> {
  AddRecipeProgress$() : super(Idle());

  void call(Progress<AddRecipeUseCase> progress) {
    emit(progress.cast<AddRecipeController>());
  }
}
