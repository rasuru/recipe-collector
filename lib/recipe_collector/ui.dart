import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/recipe_form/providers.dart';
import 'package:recipe_collector/recipe_form/ui.dart';
import 'package:recipe_collector/recipe_list/providers.dart';
import 'package:recipe_collector/recipe_list/ui.dart';
import 'package:recipe_collector/ui/theme.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class RecipeCollectorUI extends StatelessWidget {
  RecipeCollectorUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: context.read<UITheme>().flutterTheme,
      home: Scaffold(
        body: SafeArea(
          child: SlidingSheet(
            elevation: 8,
            shadowColor: Colors.black12,
            cornerRadius: 16,
            closeOnBackdropTap: true,
            snapSpec: SnapSpec(
              snap: true,
              snappings: [40, 300, double.infinity],
              positioning: SnapPositioning.pixelOffset,
            ),
            body: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: MultiProvider(
                providers: createRecipeListProviders(),
                child: RecipeListView(),
              ),
            ),
            headerBuilder: buildBottomSheetHeader,
            builder: buildBottomSheet,
          ),
        ),
      ),
    );
  }

  Widget buildBottomSheet(
    BuildContext context,
    SheetState state,
  ) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: MultiProvider(
        providers: createRecipeFormProviders(),
        child: RecipeForm(),
      ),
    );
  }

  Widget buildBottomSheetHeader(
    BuildContext context,
    SheetState state,
  ) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(top: 8),
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
