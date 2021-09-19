import 'package:sliding_sheet/sliding_sheet.dart';

extension SlidingSheetControllerExtension on SheetController {
  /// Calling `expand` once does not do the job.
  Future<void> fullyExpand() async {
    await expand();
    await expand();
  }
}
