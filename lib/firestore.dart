import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'log.dart';

extension SafeDocumentSnapshotGet on DocumentSnapshot {
  T? getOrNull<T>(String field) {
    try {
      return get(field);
    } on StateError {
      return null;
    }
  }

  T getOrDefault<T>(String field, T defaultValue) =>
      this.getOrNull(field) ?? defaultValue;
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
