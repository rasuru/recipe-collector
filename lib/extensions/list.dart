extension ListExtension<A> on List<A> {
  List<A> append(A item) => [...this, item];

  List<A> dropItem(int index) {
    return [
      for (int i = 0; i < this.length; i++)
        if (i != index) this[i]
    ];
  }
}
