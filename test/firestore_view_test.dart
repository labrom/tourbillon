import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/fake_firestore.dart';
import 'package:tourbillon/firestore.dart';
import 'package:tourbillon/firestore_view.dart';

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
        child: Builder(
          builder: (_) => FirestoreView.basicName('test_data'),
        ),
      ),
    ));
    await tester.idle();
    await tester.pump();
    expect(find.text('Roro'), findsOneWidget);
  });
  testWidgets('filter', (tester) async {
    final fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Roro',
    });
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Riri',
    });
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: Provider<FirestoreInterface>.value(
        value: fakeFirestoreWrapper,
        child: Builder(
          builder: (_) => FirestoreView.basicName(
            'test_data',
            queryModifier: (collectionRef) =>
                collectionRef.where('name', isEqualTo: 'Roro'),
          ),
        ),
      ),
    ));
    await tester.idle();
    await tester.pump();
    expect(find.text('Roro'), findsOneWidget);
    expect(find.text('Riri'), findsNothing);
  });
  testWidgets('limit', (tester) async {
    final fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Roro',
    });
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Riri',
    });
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: Provider<FirestoreInterface>.value(
        value: fakeFirestoreWrapper,
        child: Builder(
          builder: (_) => FirestoreView.basicName(
            'test_data',
            queryModifier: (collectionRef) => collectionRef.limit(1),
          ),
        ),
      ),
    ));
    await tester.idle();
    await tester.pump();
    expect(find.text('Roro'), findsOneWidget);
    expect(find.text('Riri'), findsNothing);
  });
  testWidgets('order limit', (tester) async {
    final fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Roro',
    });
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Riri',
    });
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: Provider<FirestoreInterface>.value(
        value: fakeFirestoreWrapper,
        child: Builder(
          builder: (_) => FirestoreView.basicName(
            'test_data',
            queryModifier: (collectionRef) =>
                collectionRef.orderBy('name', descending: false).limit(1),
          ),
        ),
      ),
    ));
    await tester.idle();
    await tester.pump();
    expect(find.text('Riri'), findsOneWidget);
    expect(find.text('Roro'), findsNothing);
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
  testWidgets('tile', (tester) async {
    final fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Roro',
    });
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Provider<FirestoreInterface>.value(
          value: fakeFirestoreWrapper,
          child: Builder(
            builder: (_) => FirestoreView.tile(
              'test_data',
              titleField: 'name',
            ),
          ),
        ),
      ),
    ));
    await tester.idle();
    await tester.pump();
    expect(find.text('Roro'), findsOneWidget);
  });
  testWidgets('tile with subtitle', (tester) async {
    final fakeFirestoreWrapper = FakeFirestoreWrapper();
    await fakeFirestoreWrapper.fake.collection('test_data').add({
      'name': 'Roro',
      'cats': 1,
    });
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Provider<FirestoreInterface>.value(
          value: fakeFirestoreWrapper,
          child: Builder(
            builder: (_) => FirestoreView.tile(
              'test_data',
              titleField: 'name',
              subtitleField: 'cats',
            ),
          ),
        ),
      ),
    ));
    await tester.idle();
    await tester.pump();
    expect(find.text('Roro'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
  });
}
