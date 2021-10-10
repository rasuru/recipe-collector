import 'dart:typed_data';

import 'package:dartz/dartz.dart';

class Recipe {
  final String id;
  final String name;
  final Option<Uint8List> optionalCoverImage;
  final Option<Duration> preparationTime;

  Recipe({
    required this.id,
    required this.name,
    required this.optionalCoverImage,
    required Duration preparationTime,
  }) : preparationTime = option(
          preparationTime.inMinutes > 0,
          preparationTime,
        );
}
