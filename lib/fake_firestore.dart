import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:tourbillon/firestore.dart';

class FakeFirestoreWrapper implements FirestoreInterface {
  final fake = FakeFirebaseFirestore();

  @override
  FirebaseFirestore get instance => fake;
}

extension FakeFirebaseFirestoreExtension on FakeFirebaseFirestore {
  /// FakeFirebaseFirestore doesn't seem to notify on the last write operation,
  /// so adding this function that performs an extra write to make sure all
  /// relevant writes are notified on.
  Future<void> flush() async => await collection('_').add({});
}
