import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/extensions/global.dart';
import 'package:recipe_collector/progress.dart';

import '../../close_form.dart';
import '../state.dart';
import 'save_changes.dart';

class SaveChangesButton extends StatefulWidget {
  final bool Function() validate;
  final String recipeID;

  const SaveChangesButton({
    Key? key,
    required this.recipeID,
    required this.validate,
  }) : super(key: key);

  @override
  _SaveChangesButtonState createState() => _SaveChangesButtonState();
}

class _SaveChangesButtonState extends State<SaveChangesButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveChangesProgress$, Progress>(
      builder: (context, progress) {
        return ElevatedButton.icon(
          onPressed: () {
            if (widget.validate()) {
              saveChanges(context, recipeID: widget.recipeID);
              context.read<CloseRecipeForm>()();
            }
          }.nullifyIf(progress.isActive),
          icon: Icon(FlutterRemix.pencil_line),
          label: Text('Save'),
        );
      },
    );
  }
}
