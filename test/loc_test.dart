import 'package:test/test.dart';
import 'package:tourbillon/loc.dart';

void main() {
  test('good interpolation', () {
    expect('bonjour {}'.withParam('madame'), equals('bonjour madame'));
    expect('{} madame'.withParam('bonjour'), equals('bonjour madame'));

    expect('{param1} madame'.withParam('bonjour'), equals('bonjour madame'));
    expect('{param-1} madame'.withParam('bonjour'), equals('bonjour madame'));
    expect('{param_1} madame'.withParam('bonjour'), equals('bonjour madame'));
    expect('{param1} madame'.withParams({'param1': 'bonjour'}),
        equals('bonjour madame'));
    expect('{{1}} madame'.withParams({'{1}': 'bonjour'}),
        equals('bonjour madame'));
    expect(
        '{param1} madame'
            .withParams({'param1': 'bonjour', 'param2': 'monsieur'}),
        equals('bonjour madame'));
    expect('{param-1} madame'.withParams({'param-1': 'bonjour'}),
        equals('bonjour madame'));
    expect('{param_1} madame'.withParams({'param_1': 'bonjour'}),
        equals('bonjour madame'));
    expect(
        '{param1} {param2}'
            .withParams({'param1': 'bonjour', 'param2': 'madame'}),
        equals('bonjour madame'));
    expect('{1} {2}'.withParams({'1': 'bonjour', '2': 'madame'}),
        equals('bonjour madame'));
    expect(
        '{param-1} {param-2}'
            .withParams({'param-1': 'bonjour', 'param-2': 'madame'}),
        equals('bonjour madame'));
    expect(
        '{param_1} {param_2}'
            .withParams({'param_1': 'bonjour', 'param_2': 'madame'}),
        equals('bonjour madame'));
    expect('{param1} {param1}'.withParams({'param1': 'bonjour'}),
        equals('bonjour bonjour'));
    expect(
        '{param1} {param2}'
            .withParams({'param1': '{param2}', 'param2': 'bonjour'}),
        equals('{param2} bonjour'));
    expect('{param1}'.withParams({'param1': null}), equals(''));
    expect('bonjour {'.withParams({'param1': 'madame'}), equals('bonjour {'));
    expect('bonjour }'.withParams({'param1': 'madame'}), equals('bonjour }'));
    expect(
      '{ greeting {param1} }'.withParams({'param1': 'bonjour'}),
      equals('{ greeting bonjour }'),
    );
  });
  test('bad interpolation', () {
    expect('{} madame'.withParams({'param1': 'bonjour'}), equals('{} madame'));
    expect('{param1} madame'.withParams({'param2': 'bonjour'}),
        equals('{param1} madame'));
    expect(
      () => '{param1} {param2}'.withParams(
        {'param1': 'bonjour'},
        strict: true,
      ),
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          contains('param2'),
        ),
      ),
    );
  });
}
