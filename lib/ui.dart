import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'ui/router.dart';
import 'ui/theme.dart';

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
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      onGenerateRoute: (_) => null,
      builder: (_, __) => buildRouter(),
    );
  }
}
