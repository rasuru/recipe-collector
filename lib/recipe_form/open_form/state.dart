import 'package:bloc/bloc.dart';
import 'package:recipe_collector/progress.dart';

import '../domain.dart';

class OpenRecipeFormProgress$ extends Cubit<Progress<EditedRecipe>> {
  final void Function() showForm;

  OpenRecipeFormProgress$({
    required this.showForm,
  }) : super(Idle());

  void call(Progress<EditedRecipe> progress) {
    if (progress.isActive) showForm();
    emit(progress);
  }
}
