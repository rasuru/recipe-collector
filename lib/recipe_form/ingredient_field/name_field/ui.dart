import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'domain.dart';
import '../state.dart';

class IngredientNameField extends StatelessWidget {
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.watch<IngredientField$>().name$,
      decoration: InputDecoration(
        labelText: 'Ingredient #' + context.watch<IngredientNumber>().number,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (name) => validateIngredientName(name ?? ''),
    );
  }
}
