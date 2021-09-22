import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../state.dart';

class IngredientAmountField extends StatelessWidget {
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.watch<IngredientField$>().amount$,
      decoration: InputDecoration(labelText: 'Amount'),
    );
  }
}
