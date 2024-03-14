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

  //mapIndexed
  Iterable<R> mapIndexed<R>(R Function(int index, T element) convert) sync* {
  var index = 0;
  for (var element in this) {
    yield convert(index++, element);
  }
}
}
