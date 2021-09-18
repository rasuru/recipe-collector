extension SqlbriteQuery<A> on Stream<Future<List<A>> Function()> {
  Stream<Future<List<B>>> mapRows<B>(B Function(A) mapper) {
    return map((loadRows) async {
      final rows = await loadRows();

      return rows.map(mapper).toList();
    });
  }
}
