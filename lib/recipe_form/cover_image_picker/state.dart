import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class CoverImage$ extends Cubit<Option<Uint8List>> {
  CoverImage$() : super(None());

  void reset() => emit(None());

  void set(Uint8List image) => emit(Some(image));
}
