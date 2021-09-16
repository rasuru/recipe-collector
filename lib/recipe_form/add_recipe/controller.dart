import 'use_case.dart';

class AddRecipeController {
  final AddRecipeUseCase useCase;

  AddRecipeController(this.useCase);

  void call({
    required String? name,
  }) =>
      useCase(
        name: name ?? '',
      );
}
