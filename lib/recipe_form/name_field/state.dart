import 'package:bloc/bloc.dart';

class Name$ extends Cubit<String> {
  Name$() : super('');

  void call(String name) => emit(name);
}
