import 'package:dartz/dartz.dart';

class EditedRecipe {
  final Option<String> maybeID;
  final String name;

  EditedRecipe({
    required this.maybeID,
    required this.name,
  });

  EditedRecipe.empty()
      : maybeID = None(),
        name = '';

  bool get isNewRecipe => maybeID.isNone();
}
