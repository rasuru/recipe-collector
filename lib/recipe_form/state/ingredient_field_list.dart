import 'package:bloc/bloc.dart';
import 'package:recipe_collector/extensions/list.dart';

import '../ingredient_field/state.dart';
import '../open_form/state.dart';

class IngredientFieldList$ extends Cubit<List<IngredientField$>> {
  IngredientFieldList$.fromFields(List<IngredientField$> fields)
      : super(fields);
  IngredientFieldList$(List<EditedIngredient> ingredients)
      : super(ingredients.map((ingredient) {
          return IngredientField$(
            initialName: ingredient.name,
            initialAmount: ingredient.amount,
          );
        }).toList());

  void addField() => emit(state.append(IngredientField$.empty()));
  void removeField(int index) => emit(state.dropItem(index));

  List<Ingredient> get ingredients => state.map((field) {
        return Ingredient(
          name: field.name$.text,
          amount: field.amount$.text,
        );
      }).toList();

  bool get userCanRemoveFields => state.length > 1;
}

class Ingredient {
  final String name;
  final String amount;

  Ingredient({
    required this.name,
    required this.amount,
  });
}
