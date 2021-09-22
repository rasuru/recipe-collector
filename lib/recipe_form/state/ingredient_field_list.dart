import 'package:bloc/bloc.dart';
import 'package:recipe_collector/extensions/list.dart';

import '../ingredient_field/state.dart';

class IngredientFieldList$ extends Cubit<List<IngredientField$>> {
  IngredientFieldList$() : super([IngredientField$.empty()]);

  void addField() => emit(state.append(IngredientField$.empty()));
  void removeField(int index) => emit(state.dropItem(index));
}
