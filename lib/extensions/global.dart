extension Global<A> on A {
  A? nullifyIf(bool b) => b ? null : this;
}

extension FunctionExtension<B> on B Function() {
  Future<B> after(Duration delay) => Future.delayed(delay).then((_) => this());
}
