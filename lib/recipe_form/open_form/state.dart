import 'package:bloc/bloc.dart';
import 'package:recipe_collector/progress.dart';

import '../domain.dart';

class OpenRecipeFormProgress$ extends Cubit<Progress<EditedRecipe>> {
  OpenRecipeFormProgress$() : super(Idle());

  void call(Progress<EditedRecipe> progress) {
    emit(progress);
  }
}
