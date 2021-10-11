import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/extensions/global.dart';
import 'package:recipe_collector/progress.dart';

import '../../close_form.dart';
import '../state.dart';
import 'save_changes.dart';

class AddRecipeButton extends StatefulWidget {
  final bool Function() validate;

  const AddRecipeButton({
    Key? key,
    required this.validate,
  }) : super(key: key);

  @override
  _AddRecipeButtonState createState() => _AddRecipeButtonState();
}

class _AddRecipeButtonState extends State<AddRecipeButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveChangesProgress$, Progress>(
      builder: (context, progress) {
        return ElevatedButton(
          onPressed: () {
            if (widget.validate()) {
              saveChanges(context);
              context.read<CloseRecipeForm>()();
            }
          }.nullifyIf(progress.isActive),
          child: Icon(FlutterRemix.check_line),
        );
      },
    );
  }
}
