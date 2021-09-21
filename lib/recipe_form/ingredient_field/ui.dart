import 'package:flutter/material.dart';

import 'amount_field/ui.dart';
import 'name_field/ui.dart';

class IngredientField extends StatelessWidget {
  const IngredientField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: IngredientNameField()),
        SizedBox(width: 10),
        SizedBox(
          width: 100,
          child: IngredientAmountField(),
        ),
      ],
    );
  }
}
