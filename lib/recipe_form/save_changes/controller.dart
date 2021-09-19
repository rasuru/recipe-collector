import 'use_case.dart';

class SaveChangesController {
  final SaveChangesUseCase useCase;

  SaveChangesController(this.useCase);

  void call({
    required String id,
    required String? name,
  }) =>
      useCase(
        id: id,
        name: name,
      );
}
