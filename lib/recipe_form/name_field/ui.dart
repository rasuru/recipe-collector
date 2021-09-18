import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'domain.dart';

import '../state/name.dart';

class NameField extends StatelessWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: context.read<RecipeName$>().emit,
      validator: (name) => validateRecipeName(name ?? ''),
    );
  }
}
