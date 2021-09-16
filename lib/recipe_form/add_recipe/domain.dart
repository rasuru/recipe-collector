import 'package:uuid/uuid.dart';

String generateNewRecipeID() {
  return Uuid().v4();
}
