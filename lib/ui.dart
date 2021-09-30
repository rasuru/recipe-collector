import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/ui/padding.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'progress.dart';
import 'recipe_form/domain.dart';
import 'recipe_form/open_form/state.dart';
import 'recipe_form/open_form/use_case.dart';
import 'recipe_form/providers.dart';
import 'recipe_form/ui.dart';
import 'recipe_list/providers.dart';
import 'recipe_list/ui.dart';
import 'ui/theme.dart';
import 'ui/toast_overlay.dart';

class RecipeCollectorUI extends StatefulWidget {
  RecipeCollectorUI({
    Key? key,
  }) : super(key: key);

  @override
  State<RecipeCollectorUI> createState() => _RecipeCollectorUIState();
}

class _RecipeCollectorUIState extends State<RecipeCollectorUI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: context.read<UITheme>().flutterTheme,
      home: buildScaffold(Padding(
        padding: paddingOf(bottom: 30),
        child: MultiProvider(
          providers: createRecipeListProviders(),
          child: RecipeListView(),
        ),
      )),
    );
  }

  Widget buildScaffold(Widget child) {
    return Scaffold(
      body: SafeArea(
        child: ToastOverlay(
          wrapWithBottomSheet(child),
        ),
      ),
    );
  }

  Widget wrapWithBottomSheet(Widget child) {
    return SlidingSheet(
      controller: context.watch<SheetController>(),
      elevation: 8,
      shadowColor: Colors.black12,
      cornerRadius: 16,
      closeOnBackdropTap: true,
      snapSpec: SnapSpec(
        snap: true,
        snappings: [40, 300, double.infinity],
        positioning: SnapPositioning.pixelOffset,
      ),
      body: child,
      headerBuilder: buildBottomSheetHeader,
      builder: buildBottomSheet,
    );
  }

  Widget buildBottomSheet(
    BuildContext context,
    SheetState state,
  ) {
    return Padding(
      padding: paddingOf(all: 20),
      child: BlocBuilder<OpenRecipeFormProgress$, Progress<EditedRecipe>>(
        builder: buildRecipeFormLoader,
      ),
    );
  }

  Widget buildRecipeFormLoader(
    BuildContext context,
    Progress<EditedRecipe> progress,
  ) {
    return progress.fold(
      ifIdle: () {
        context.read<OpenRecipeFormUseCase>().emptyForm();
        return Container();
      },
      ifActive: () => Center(child: CircularProgressIndicator()),
      ifCompleted: (editedRecipe) {
        return MultiProvider(
          key: ValueKey(editedRecipe),
          providers: createRecipeFormProviders(
            context: context,
            editedRecipe: editedRecipe,
          ),
          child: RecipeForm(),
        );
      },
      ifFailed: (_) => Center(child: Text('Error')),
    );
  }

  Widget buildBottomSheetHeader(
    BuildContext context,
    SheetState state,
  ) {
    return Container(
      height: 40,
      padding: paddingOf(top: 8),
      alignment: Alignment.topCenter,
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
