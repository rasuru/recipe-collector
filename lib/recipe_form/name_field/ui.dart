import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'domain.dart';

import 'state.dart';

class NameField extends StatelessWidget {
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.watch<Name$>().textEditingController,
      decoration: InputDecoration(labelText: 'Name'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (name) => validateRecipeName(name ?? ''),
    );
  }
}
