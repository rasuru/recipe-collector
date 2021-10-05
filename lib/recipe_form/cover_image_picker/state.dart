import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class CoverImage$ extends Cubit<Option<Uint8List>> {
  CoverImage$(Option<Uint8List> initial) : super(initial);

  void reset() => emit(None());

  void set(Uint8List image) => emit(Some(image));
}
