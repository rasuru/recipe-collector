import 'package:uuid/uuid.dart';

String generateNewRecipeID() {
  return Uuid().v4();
}

class Ingredient {
  final String name;
  final String? amount;

  Ingredient({
    required this.name,
    required this.amount,
  });
}
