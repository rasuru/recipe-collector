import 'package:dartz/dartz.dart';

extension Global<A> on A {
  A? nullifyIf(bool b) => b ? null : this;

  Option<A> when(bool Function(A) test) => option(test(this), this);
}

extension FunctionExtension<B> on B Function() {
  Future<B> after(Duration delay) => Future.delayed(delay).then((_) => this());
}
