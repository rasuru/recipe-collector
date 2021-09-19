import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/extensions/global.dart';
import 'package:recipe_collector/progress.dart';
import 'package:recipe_collector/ui/theme.dart';
import 'package:recipe_collector/ui/widgets/success_message.dart';
import 'package:time/time.dart';

import '../name_field/state.dart';
import 'controller.dart';
import 'state.dart';

class EditRecipeButton extends StatefulWidget {
  final bool Function() validate;
  final String recipeID;

  const EditRecipeButton({
    Key? key,
    required this.recipeID,
    required this.validate,
  }) : super(key: key);

  @override
  _EditRecipeButtonState createState() => _EditRecipeButtonState();
}

class _EditRecipeButtonState extends State<EditRecipeButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaveChangesProgress$, Progress>(
      builder: (context, progress) {
        return ElevatedButton.icon(
          onPressed: () {
            if (widget.validate()) {
              _editRecipe();
            }
          }.nullifyIf(progress.isActive),
          icon: Icon(Icons.edit),
          label: Text('Save'),
        );
      },
    );
  }

  void _editRecipe() {
    final saveChanges = context.read<SaveChangesController>();

    saveChanges(
      id: widget.recipeID,
      name: context.read<Name$>().state,
    );
  }

  late final FToast fToast;
  late final StreamSubscription _toastListener;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _toastListener = context
        .read<SaveChangesProgress$>()
        .stream
        .listen(handleEditRecipeProgress);
  }

  void handleEditRecipeProgress(Progress progress) {
    if (progress.isCompleted) {
      fToast.removeCustomToast();
      showSuccesssMessage();
    }
  }

  void showSuccesssMessage() {
    fToast.showToast(
      gravity: ToastGravity.CENTER,
      toastDuration: 2.seconds,
      child: MultiProvider(
        providers: [
          Provider.value(value: context.read<UITheme>()),
        ],
        child: SuccessMessage(message: 'Changes are saved'),
      ),
    );
  }

  @override
  void dispose() {
    _toastListener.cancel();
    super.dispose();
  }
}
