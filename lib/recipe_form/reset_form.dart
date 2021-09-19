import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ResetRecipeForm {
  final GlobalKey<FormState> formKey;
  final SheetController sheetController;

  ResetRecipeForm({
    required this.formKey,
    required this.sheetController,
  });

  Future<void> call() async {
    formKey.currentState!.reset();
    await sheetController.expand();
  }
}
