import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/delete_recipe/state.dart';
import 'package:recipe_collector/recipe_form/save_changes/state.dart';

import 'widgets/success_message.dart';

class ToastOverlay extends StatefulWidget {
  final Widget child;

  ToastOverlay(this.child);

  @override
  State<ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<ToastOverlay> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    initDeleteRecipeProgressHandler();
    initSaveChangesProgressHandler();
  }

  late final StreamSubscription deleteRecipeProgressHandler;
  void initDeleteRecipeProgressHandler() {
    final deleteRecipeProgress$ = context.read<DeleteRecipeProgress$>();
    deleteRecipeProgressHandler =
        deleteRecipeProgress$.stream.listen((progress) {
      if (progress.isCompleted) {
        showToastWidget(
          SuccessMessage(message: 'Recipe deleted'),
          context: context,
          position: StyledToastPosition.top,
        );
      }
    });
  }

  late final StreamSubscription saveChangesProgressHandler;
  void initSaveChangesProgressHandler() {
    final saveChangesProgress$ = context.read<SaveChangesProgress$>();
    saveChangesProgressHandler = saveChangesProgress$.stream.listen((progress) {
      if (progress.isCompleted) {
        showToastWidget(
          SuccessMessage(message: 'Recipe saved'),
          context: context,
          position: StyledToastPosition.top,
        );
      }
    });
  }

  @override
  void dispose() {
    deleteRecipeProgressHandler.cancel();
    super.dispose();
  }
}
