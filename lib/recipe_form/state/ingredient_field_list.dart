import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../ingredient_field/state.dart';

class IngredientFieldList$ extends Cubit<List<IngredientField$>> {
  IngredientFieldList$()
      : super([
          IngredientField$(
            name$: TextEditingController(),
            amount$: TextEditingController(),
          ),
          IngredientField$(
            name$: TextEditingController(),
            amount$: TextEditingController(),
          ),
          IngredientField$(
            name$: TextEditingController(),
            amount$: TextEditingController(),
          ),
        ]);
}
