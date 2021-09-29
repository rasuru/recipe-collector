import 'package:bloc/bloc.dart';
import 'package:recipe_collector/extensions/list.dart';

import '../ingredient_field/state.dart';
import '../add_recipe/controller.dart';

class IngredientFieldList$ extends Cubit<List<IngredientField$>> {
  IngredientFieldList$() : super([IngredientField$.empty()]);

  void addField() => emit(state.append(IngredientField$.empty()));
  void removeField(int index) => emit(state.dropItem(index));

  List<Ingredient> get ingredients => state.map((field) {
        return Ingredient(
          name: field.name$.text,
          amount: field.amount$.text,
        );
      }).toList();
}
