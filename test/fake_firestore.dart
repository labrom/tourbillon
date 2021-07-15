import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:tourbillon/firestore.dart';

class FakeFirestoreWrapper implements FirestoreInterface {
  final fake = FakeFirebaseFirestore();

  @override
  FirebaseFirestore get instance => fake;
}
