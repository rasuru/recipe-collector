import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_collector/progress.dart';

class DeleteRecipeProgress$ extends Cubit<Progress> {
  final recipeID$ = DeletedRecipeID$();

  DeleteRecipeProgress$() : super(Idle());

  void call({
    required String id,
    required Progress progress,
  }) {
    recipeID$.emit(optionOf(progress.isIdle ? null : id));
    emit(progress);
  }

  @override
  Future<void> close() async {
    await recipeID$.close();
    await super.close();
  }
}

class DeletedRecipeID$ extends Cubit<Option<String>> {
  DeletedRecipeID$() : super(None());
}
