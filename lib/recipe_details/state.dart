import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_collector/progress.dart';

import 'domain.dart';

class ViewRecipeProgress$ extends Cubit<Progress<Recipe>> {
  ViewRecipeProgress$() : super(Idle());
}

class ViewedRecipeID$ extends Cubit<Option<String>> {
  ViewedRecipeID$() : super(None());

  void set(String id) => emit(Some(id));
  void reset() => emit(None());
}
