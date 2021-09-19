import 'use_case.dart';

class SaveChanges {
  final SaveChangesUseCase useCase;

  SaveChanges(this.useCase);

  void call({
    required String id,
    required String? name,
  }) =>
      useCase(
        id: id,
        name: name,
      );
}
