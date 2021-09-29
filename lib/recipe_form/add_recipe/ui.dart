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

import '../close_form.dart';
import '../name_field/state.dart';
import '../state/ingredient_field_list.dart';
import 'controller.dart';
import 'state.dart';

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
    return BlocBuilder<AddRecipeProgress$, Progress>(
      builder: (context, progress) {
        return ElevatedButton(
          onPressed: () {
            if (widget.validate()) {
              _addRecipe();
              context.read<CloseRecipeForm>()();
            }
          }.nullifyIf(progress.isActive),
          child: Icon(Icons.check),
        );
      },
    );
  }

  void _addRecipe() {
    final addRecipe = context.read<AddRecipeController>();

    addRecipe(
      name: context.read<Name$>().state,
      ingredients: context.read<IngredientFieldList$>().ingredients,
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
        .read<AddRecipeProgress$>()
        .stream
        .listen(handleAddRecipeProgress);
  }

  void handleAddRecipeProgress(Progress progress) {
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
        child: SuccessMessage(message: 'Recipe added'),
      ),
    );
  }

  @override
  void dispose() {
    _toastListener.cancel();
    super.dispose();
  }
}
