extension Global<A> on A {
  A? nullifyIf(bool b) => b ? null : this;
}
