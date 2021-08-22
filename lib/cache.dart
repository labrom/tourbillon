class Cache<T> {
  final _data = <String, _Entry<T>>{};

  void clear() => _data.clear();

  int get length => _data.length;

  T? operator [](String key) => _data[key]?.value;

  void operator []=(String key, T value) => _data[key] = _Entry(value);

  bool isStale(String key) => _data[key]!.stale;

  void setStale(String key) => _data[key]!.stale = true;

  void setAllStale() {
    for (var value in _data.values) {
      value.stale = true;
    }
  }
}

class _Entry<T> {
  var stale = false;
  final T value;

  _Entry(this.value);
}
