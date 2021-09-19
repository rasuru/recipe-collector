import 'package:recipe_collector/progress.dart';

class SaveChangesUseCase {
  final Future<void> Function({
    required String id,
    required String? name,
  }) update;
  final void Function(Progress) present;

  SaveChangesUseCase({
    required this.update,
    required this.present,
  });

  Future<void> call({
    required String id,
    required String? name,
  }) async {
    present(Active());
    await update(
      id: id,
      name: name,
    );
    present(Completed(null));
  }
}
