import 'package:flutter/material.dart';

class ResetFormButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  ResetFormButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => formKey.currentState!.reset(),
      child: Text('Reset'),
    );
  }
}
