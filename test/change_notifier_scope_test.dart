import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/change_notifier_scope.dart';

void main() {
  testWidgets('Provider presence', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: ChangeNotifierScope((_) => _TestChangeNotifier(),
          builder: (__, ___, ____) => _TestChangeNotifierConsumer()),
    ));
  });
  testWidgets('Provider value', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: ChangeNotifierScope((_) => _TestChangeNotifier(),
          builder: (__, ___, ____) => _TestChangeNotifierConsumer()),
    ));
    expect(find.text('Count: 0'), findsOneWidget);
  });
  testWidgets('Provider value change', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child:
          ChangeNotifierScope<_TestChangeNotifier>((_) => _TestChangeNotifier(),
              builder: (__, provider, ___) => Row(
                    children: [
                      _TestChangeNotifierConsumer(),
                      TextButton(
                          onPressed: () => provider.bump(), child: Text('Bump'))
                    ],
                  )),
    ));
    expect(find.text('Count: 0'), findsOneWidget);
    await tester.tap(find.text('Bump'));
    await tester.pump();
    expect(find.text('Count: 1'), findsOneWidget);
  });
  testWidgets('Provider exists in parent', (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child:
          ChangeNotifierScope<_TestChangeNotifier>((_) => _TestChangeNotifier(),
              builder: (__, provider, ___) => Row(
                    children: [
                      _TestChangeNotifierConsumer(),
                      TextButton(
                          onPressed: () => provider.bump(),
                          child: Text('Bump')),
                      ChangeNotifierScope<_TestChangeNotifier>(
                          (_) => _TestChangeNotifier(),
                          builder: (__, provider, ___) =>
                              _TestChangeNotifierConsumer(
                                label: 'Count from parent',
                              )),
                    ],
                  )),
    ));
    expect(find.text('Count: 0'), findsOneWidget);
    expect(find.text('Count from parent: 0'), findsOneWidget);
    await tester.tap(find.text('Bump'));
    await tester.pump();
    expect(find.text('Count: 1'), findsOneWidget);
    expect(find.text('Count from parent: 1'), findsOneWidget);
  });
}

class _TestChangeNotifier extends ChangeNotifier {
  int count = 0;

  void bump() {
    count++;
    notifyListeners();
  }
}

class _TestChangeNotifierConsumer extends StatelessWidget {
  final String label;

  _TestChangeNotifierConsumer({this.label = 'Count'});

  @override
  Widget build(BuildContext context) {
    return Text('$label: ${context.watch<_TestChangeNotifier>().count}');
  }
}
