import 'package:bloc/bloc.dart';
import 'package:recipe_collector/progress.dart';

import 'controller.dart';
import 'use_case.dart';

class AddRecipe$ extends Cubit<Progress<AddRecipeController>> {
  AddRecipe$() : super(Idle());

  void call(Progress<AddRecipeUseCase> progress) {
    emit(progress.cast<AddRecipeController>());
  }
}

class RecipeName$ extends Cubit<String?> {
  RecipeName$() : super(null);
}
