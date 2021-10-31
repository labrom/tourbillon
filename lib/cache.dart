class Cache<T> {
  final _data = <String, _Entry<T>>{};

  /// Gets all the cache entries that aren't stale.
  Map<String, T> get map => Map.fromEntries(_data.entries
      .where((entry) => !entry.value.stale)
      .map((entry) => MapEntry(entry.key, entry.value.value)));

  void clear() => _data.clear();

  /// Looks up the value for a given key and returns it if it isn't stale.
  T? operator [](String key) =>
      _data[key]?.stale == false ? _data[key]!.value : null;

  /// Puts a non-stale value with a given key.
  void operator []=(String key, T value) => _data[key] = _Entry(value);

  T? remove(String key) => _data.remove(key)?.value;

  bool isStale(String key) => _data[key]?.stale != false;

  void setStale(String key) => _data[key]?.stale = true;

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
