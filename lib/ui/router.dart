import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_collector/recipe_details/state.dart';

import 'routes/home.dart';
import 'routes/recipe_details.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Widget buildRouter() {
  return BlocBuilder<ViewedRecipe$, Option<String>>(
    builder: (context, viewedRecipe) {
      return Navigator(
        key: navigatorKey,
        pages: [
          RecipeListRoute.build(),
          if (viewedRecipe.isSome()) RecipeDetailsRoute.build(),
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
    context.read<ViewedRecipe$>().unset();
  }

  return true;
}
