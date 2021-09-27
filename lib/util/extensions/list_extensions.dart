extension ListExtension<T> on List<T> {
  List<List<T>> chunk(int len) {
    int pos = 0;
    List<List<T>> res = List.empty(growable: true);
    while (pos < length) {
      res.add(sublist(pos, pos + len));
      pos += len;
    }
    return res;
  }
}
