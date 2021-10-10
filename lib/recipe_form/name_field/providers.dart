import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../open_form/state.dart';
import 'state.dart';

List<Provider> createNameFieldProviders() {
  return [
    Provider<Name$>(
      create: (context) => Name$(
        textEditingController: TextEditingController(
          text: context.read<EditedRecipe>().name,
        ),
      ),
    ),
  ];
}
