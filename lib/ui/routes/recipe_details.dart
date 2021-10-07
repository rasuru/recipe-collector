import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:recipe_collector/extensions/option.dart';
import 'package:recipe_collector/recipe_details/state.dart';

import '../toast_overlay.dart';

class RecipeDetailsRoute {
  static const key = ValueKey('recipe-details');

  static MaterialPage build() {
    return MaterialPage(
      key: key,
      child: Scaffold(
        body: SafeArea(
          child: ToastOverlay(
            Center(
              child: BlocBuilder<ViewedRecipe$, Option<String>>(
                builder: (_, id) {
                  if (id.isNone()) return Container();

                  return Provider<String>.value(
                    value: id.value,
                    child: Text('ID ${id.value}'),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
