import 'dart:typed_data';

import 'package:dartz/dartz.dart';

class Recipe {
  final String id;
  final String name;
  final Option<Uint8List> optionalCoverImage;

  Recipe({
    required this.id,
    required this.name,
    required this.optionalCoverImage,
  });
}
