import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'log.dart';

part 'firestore.g.dart';
part 'firestore.freezed.dart';

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref, {String? database}) => database ==
        null
    ? FirebaseFirestore.instance
    : FirebaseFirestore.instanceFor(app: Firebase.app(), databaseId: database);

/// A common interface for [FirebaseFirestore] and for a fake Firestore used
/// in tests.
abstract class FirestoreInterface {
  FirebaseFirestore get instance;
}

class _FirebaseFirestoreWrapper implements FirestoreInterface {
  static const _wrapper = _FirebaseFirestoreWrapper._();

  const _FirebaseFirestoreWrapper._();

  factory _FirebaseFirestoreWrapper() => _wrapper;

  @override
  FirebaseFirestore get instance => FirebaseFirestore.instance;
}

/// Obtains the Firestore provider from the context.
///
/// Widgets that use this function insteand of accessing directly
/// [FirebaseFirestore] can have their tests inject a fake Firestore as a
/// [p.Provider] of [FirestoreInterface].
/// Apps do not need to inject [FirebaseFirestore] using a [p.Provider], this
/// function will automatically return it if no [FirestoreInterface] already
/// exists in the context.
FirestoreInterface firestoreProvider(BuildContext context) =>
    context.read<FirestoreInterface?>() ?? _FirebaseFirestoreWrapper();

@riverpod
CollectionReference<Map<String, dynamic>> firestoreCollectionReference(
    Ref ref, String path,
    {String? database}) {
  return firebaseFirestore(ref, database: database).collection(path);
}

@riverpod
DocumentReference<Map<String, dynamic>> firestoreDocumentReference(
    Ref ref, String path,
    {String? database}) {
  return firebaseFirestore(ref, database: database).doc(path);
}

@riverpod
Future<DocumentSnapshot<Map<String, dynamic>>> firestoreDocument(
    Ref ref, String path,
    {String? database}) async {
  return firestoreDocumentReference(ref, path, database: database).get();
}

@riverpod
Stream<DocumentSnapshot<Map<String, dynamic>>> firestoreDocumentStream(
    Ref ref, String path,
    {String? database}) {
  return firestoreDocumentReference(ref, path, database: database).snapshots();
}

@riverpod
Query<Map<String, dynamic>> firestoreQuery(Ref ref, String collectionPath,
    {String? database, OrderBy? orderBy}) {
  Query<Map<String, dynamic>> query =
      firestoreCollectionReference(ref, collectionPath, database: database);
  var ob = orderBy;
  while (ob != null) {
    query = query.orderBy(ob.fieldPath, descending: ob.descending);
    ob = ob.next;
  }
  return query;
}

@riverpod
Stream<QuerySnapshot<Map<String, dynamic>>> firestoreQueryStream(
        Ref ref, String collectionPath, {String? database, OrderBy? orderBy}) =>
    firestoreQuery(ref, collectionPath, database: database, orderBy: orderBy)
        .snapshots();

@riverpod
Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
    firestoreQueryDocumentList(Ref ref, String collectionPath,
            {String? database, OrderBy? orderBy}) async =>
        firestoreQuery(ref, collectionPath,
                database: database, orderBy: orderBy)
            .get()
            .then((querySnapshot) => querySnapshot.docs);

@freezed
class OrderBy with _$OrderBy {
  const OrderBy(this.fieldPath, {this.descending = false, this.next});
  OrderBy.field(String field, {this.descending = false, this.next})
      : fieldPath = FieldPath([field]);

  @override
  final FieldPath fieldPath;

  @override
  final bool descending;

  @override
  final OrderBy? next;
}

extension SafeDocumentSnapshotGet on DocumentSnapshot {
  T? getOrNull<T>(String field) {
    try {
      return get(field);
    } on StateError {
      return null;
    } catch (e) {
      log.w('Expected StateError but got $e');
      return null;
    }
  }

  T getOrDefault<T>(String field, T defaultValue) =>
      getOrNull(field) ?? defaultValue;

  String getStringOrDefault(String field, String defaultValue) =>
      getOrNull(field)?.toString() ?? defaultValue;

  String getString(String field) => getStringOrDefault(field, '');

  double getDoubleOrDefault(String field, double defaultValue) {
    final value = getOrNull(field);
    if (value is int) {
      return value.toDouble();
    }
    return value ?? defaultValue;
  }

  double getDouble(String field) => getDoubleOrDefault(field, 0);

  bool getBoolOrDefault(String field, bool defaultValue) =>
      getOrDefault<bool>(field, defaultValue);

  bool getBool(String field) => getBoolOrDefault(field, false);

  DateTime? getDateTimeOrNull(String field) {
    final timestamp = getOrNull<Timestamp>(field);
    if (timestamp != null) {
      return DateTime.fromMicrosecondsSinceEpoch(
          timestamp.microsecondsSinceEpoch);
    }
    return null;
  }

  List<T> getListOf<T>(String field) {
    return getOrNull<List<dynamic>>(field)?.cast<T>() ?? List<T>.empty();
  }
}

/// Extension that ensures a unique stream subscription is opened on a given
/// [QuerySnapshot].
extension QuerySnapshotMap on Stream<QuerySnapshot> {
  StreamSubscription<QuerySnapshot> listenUnique(
    void Function(QuerySnapshot event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
    required String key,
  }) =>
      _listenUnique<QuerySnapshot>(
        this,
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
        key: key,
      );
}

/// Extension that ensures a unique stream subscription is opened on a given
/// [DocumentSnapshot].
extension DocumentSnapshotMap on Stream<DocumentSnapshot> {
  StreamSubscription<DocumentSnapshot> listenUnique(
    void Function(DocumentSnapshot event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
    required String key,
  }) =>
      _listenUnique<DocumentSnapshot>(
        this,
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
        key: key,
      );
}

StreamSubscription<T> _listenUnique<T>(
  Stream<T> stream,
  void Function(T event)? onData, {
  Function? onError,
  void Function()? onDone,
  bool? cancelOnError,
  required String key,
}) =>
    _snapshotSubscriptions.update(
      key,
      (oldSubscription) {
        oldSubscription.cancel();
        log.i('Renewing subscription for $key');
        return stream.listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
      },
      ifAbsent: () {
        log.i('Creating subscription for $key');
        return stream.listen(
          onData,
          onError: onError,
          onDone: onDone,
          cancelOnError: cancelOnError,
        );
      },
    ) as StreamSubscription<T>;

final _snapshotSubscriptions = <String, StreamSubscription>{};
