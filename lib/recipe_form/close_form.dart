import 'package:sliding_sheet/sliding_sheet.dart';

import 'open_form/use_case.dart';

class CloseRecipeForm {
  final OpenRecipeFormUseCase openRecipeForm;
  final SheetController sheetController;

  CloseRecipeForm({
    required this.openRecipeForm,
    required this.sheetController,
  });

  Future<void> call() async {
    openRecipeForm.emptyForm();
    await sheetController.collapse();
  }
}
