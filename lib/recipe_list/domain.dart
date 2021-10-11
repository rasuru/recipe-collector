import 'dart:typed_data';

import 'package:dartz/dartz.dart';

class Recipe {
  final String id;
  final String name;
  final Option<Uint8List> optionalCoverImage;
  final Duration preparationTime;
  final Duration cookingTime;
  final Duration totalTime;

  Recipe({
    required this.id,
    required this.name,
    required this.optionalCoverImage,
    required this.preparationTime,
    required this.cookingTime,
    required this.totalTime,
  });
}
