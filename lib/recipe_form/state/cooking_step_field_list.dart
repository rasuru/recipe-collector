import 'package:bloc/bloc.dart';
import 'package:recipe_collector/extensions/list.dart';
import '../cooking_step_field/state.dart';

class CookingStepFieldList$ extends Cubit<List<CookingStepField$>> {
  CookingStepFieldList$(List<CookingStepField$> fields) : super(fields);

  void addField() => emit(state.append(CookingStepField$.empty()));
  void removeField(int index) => emit(state.dropItem(index));

  List<String> get steps => state.map((field) => field.text$.text).toList();

  bool get userCanRemoveFields => state.length > 1;
}
