import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

class ViewedRecipe$ extends Cubit<Option<String>> {
  ViewedRecipe$() : super(None());

  void set(String id) => emit(Some(id));
  void unset() => emit(None());
}
