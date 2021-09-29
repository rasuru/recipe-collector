extension SqlbriteQuery<A> on Stream<Future<List<A>> Function()> {
  Stream<Future<List<B>>> mapRows<B>(B Function(A) mapper) {
    return map((loadRows) async {
      final rows = await loadRows();

      return rows.map(mapper).toList();
    });
  }

  Stream<Future<List<B>>> asyncMapRows<B>(Future<B> Function(A) mapper) {
    return map((loadRows) async {
      final rows = await loadRows();

      return Future.wait(rows.map(mapper).toList());
    });
  }
}
