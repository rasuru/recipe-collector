import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'domain.dart';

import 'state.dart';

class NameField extends StatefulWidget {
  NameField({Key? key}) : super(key: key);

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  final controller = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: 'Name'),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: context.read<Name$>().emit,
      validator: (name) => validateRecipeName(name ?? ''),
    );
  }

  late final StreamSubscription stateRenderer;
  @override
  void initState() {
    super.initState();

    stateRenderer = context.read<Name$>().stream.listen((name) {
      if (controller.text == name) return;

      controller.text = name;
    });
  }

  @override
  void dispose() {
    stateRenderer.cancel();
    super.dispose();
  }
}
