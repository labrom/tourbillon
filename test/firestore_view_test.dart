import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/firestore.dart';
import 'package:tourbillon/firestore_view.dart';

import 'fake_firestore.dart';

void main() {
  testWidgets('basic', (tester) async {
    final fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Roro',
    });
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: Provider<FirestoreInterface>.value(
        value: fakeFirestoreWrapper,
        child: Builder(builder: (_) => FirestoreView.basicName('test_data')),
      ),
    ));
    await tester.idle();
    await tester.pump();
    expect(find.text('Roro'), findsOneWidget);
  });
  testWidgets('basic stream', (tester) async {
    final fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Roro',
    });
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: Provider<FirestoreInterface>.value(
        value: fakeFirestoreWrapper,
        child:
            Builder(builder: (_) => FirestoreStreamView.basicName('test_data')),
      ),
    ));
    await tester.idle();
    await tester.pump();
    expect(find.text('Roro'), findsOneWidget);
  });
}
