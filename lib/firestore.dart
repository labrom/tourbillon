import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'log.dart';

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
/// [FirebaseFirestore] can have their tests inject a fake Firestore.
/// Apps do not need to inject [FirebaseFirestore], invoking this function
/// will automatically return it if no [FirestoreInterface] exists in the
/// context.
FirestoreInterface firestoreProvider(BuildContext context) {
  try {
    return context.read<FirestoreInterface>();
  } on ProviderNotFoundException {
    return _FirebaseFirestoreWrapper();
  }
}

extension SafeDocumentSnapshotGet on DocumentSnapshot {
  T? getOrNull<T>(String field) {
    try {
      return get(field);
    } on StateError {
      return null;
    }
  }

  T getOrDefault<T>(String field, T defaultValue) =>
      getOrNull(field) ?? defaultValue;

  String getOrDefaultString(String field, String defaultValue) =>
      getOrNull(field)?.toString() ?? defaultValue;
}

/// Extension that ensures a unique stream subscription is opened on a given
/// [QuerySnapshot].
extension QuerySnapshotMap on Stream<QuerySnapshot> {
  StreamSubscription<QuerySnapshot> listenUnique(
    void onData(QuerySnapshot event)?, {
    Function? onError,
    void onDone()?,
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
    void onData(DocumentSnapshot event)?, {
    Function? onError,
    void onDone()?,
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
  void onData(T event)?, {
  Function? onError,
  void onDone()?,
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
