import 'package:bloc/bloc.dart';
import 'package:recipe_collector/progress.dart';

import 'domain.dart';

class RecipeList$ extends Cubit<Progress<List<Recipe>>> {
  RecipeList$() : super(Idle());

  void call(Progress<List<Recipe>> progress) {
    emit(progress);
  }
}
