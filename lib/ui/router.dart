import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_collector/extensions/option.dart';
import 'package:recipe_collector/recipe_details/state.dart';

import 'routes/home.dart';
import 'routes/recipe_details.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Widget buildRouter() {
  return BlocBuilder<ViewedRecipeID$, Option<String>>(
    builder: (context, maybeID) {
      return Navigator(
        key: navigatorKey,
        pages: [
          RecipeListRoute.build(),
          if (maybeID.isSome()) RecipeDetailsRoute.build(maybeID.value),
        ],
        onPopPage: (route, result) =>
            route.didPop(result) &&
            handlePagePop(context, route.settings as MaterialPage),
      );
    },
  );
}

bool handlePagePop(BuildContext context, MaterialPage page) {
  if (page.key == RecipeDetailsRoute.key) {
    context.read<ViewedRecipeID$>().reset();
  }

  return true;
}
