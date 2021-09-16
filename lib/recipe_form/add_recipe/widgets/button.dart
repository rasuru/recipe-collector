import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/extensions/global.dart';
import 'package:recipe_collector/progress.dart';
import 'package:recipe_collector/ui/theme.dart';
import 'package:recipe_collector/widgets/success_message.dart';
import 'package:time/time.dart';

import '../controller.dart';
import '../model.dart';

class AddRecipeButton extends StatefulWidget {
  const AddRecipeButton({Key? key}) : super(key: key);

  @override
  _AddRecipeButtonState createState() => _AddRecipeButtonState();
}

class _AddRecipeButtonState extends State<AddRecipeButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddRecipe$, Progress<void>>(
      builder: (context, progress) {
        return ElevatedButton(
          onPressed: _addRecipeHandler().nullifyIf(progress.isActive),
          child: Text('Add recipe'),
        );
      },
    );
  }

  void Function() _addRecipeHandler() {
    return () {
      final addRecipe = context.read<AddRecipeController>();
      final name = context.read<RecipeName$>().state;

      addRecipe(
        name: name,
      );
    };
  }

  late final StreamSubscription _toastListener;
  @override
  void initState() {
    super.initState();
    final fToast = FToast();
    fToast.init(context);
    _toastListener =
        BlocProvider.of<AddRecipe$>(context).stream.listen((progress) {
      if (progress.isCompleted) {
        fToast.removeCustomToast();
        fToast.showToast(
          gravity: ToastGravity.BOTTOM,
          toastDuration: 2.seconds,
          child: MultiProvider(
            providers: [
              Provider.value(value: context.read<UITheme>()),
            ],
            child: SuccessMessage(message: 'Recipe added'),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _toastListener.cancel();
    super.dispose();
  }
}
