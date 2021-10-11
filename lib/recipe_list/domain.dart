import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:recipe_collector/extensions/global.dart';

class Recipe {
  final String id;
  final String name;
  final Option<Uint8List> optionalCoverImage;
  final Option<Duration> preparationTime;
  final Option<Duration> cookingTime;

  Recipe({
    required this.id,
    required this.name,
    required this.optionalCoverImage,
    required Duration preparationTime,
    required Duration cookingTime,
  })  : preparationTime = preparationTime.when((it) => it.inMinutes > 0),
        cookingTime = cookingTime.when((it) => it.inMinutes > 0);
}
