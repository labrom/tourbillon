import 'package:test/test.dart';
import 'package:tourbillon/cache.dart';

void main() {
  test('basic', () {
    var cache = Cache<String>();
    cache['a'] = 'A';
    cache['b'] = 'B';
    expect(cache['a'], equals('A'));
    expect(cache['b'], equals('B'));
    expect(cache.remove('a'), equals('A'));
    expect(cache['a'], isNull);
    expect(cache['b'], equals('B'));
    cache.clear();
    expect(cache['b'], isNull);
  });
  test('stale', () {
    var cache = Cache<String>();
    cache['a'] = 'A';
    cache['b'] = 'B';
    cache.setStale('b');
    expect(cache['a'], equals('A'));
    expect(cache['b'], isNull);
    expect(cache.isStale('b'), isTrue);
    cache['b'] = 'BB';
    expect(cache['b'], equals('BB'));
    cache.setAllStale();
    expect(cache['a'], isNull);
    expect(cache.isStale('a'), isTrue);
    expect(cache['b'], isNull);
    expect(cache.isStale('b'), isTrue);
  });
  test('stale - null safety', () {
    var cache = Cache<String>();
    cache['a'] = 'A';
    cache.setStale('b');
    expect(cache.isStale('a'), isFalse);
    expect(cache.isStale('b'), isTrue);
    expect(cache.isStale('c'), isTrue);
  });
}
