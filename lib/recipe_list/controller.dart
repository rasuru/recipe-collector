import 'use_case.dart';

class ViewRecipeListController {
  final ViewRecipeListUseCase useCase;

  ViewRecipeListController(this.useCase);

  void call() => useCase();
}
