import 'package:dartz/dartz.dart';

extension OptionExtension<A> on Option<A> {
  A get value => getOrElse(() => throw Exception('No value'));
}
