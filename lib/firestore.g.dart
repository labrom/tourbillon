// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseFirestore)
const firebaseFirestoreProvider = FirebaseFirestoreFamily._();

final class FirebaseFirestoreProvider extends $FunctionalProvider<
    FirebaseFirestore,
    FirebaseFirestore,
    FirebaseFirestore> with $Provider<FirebaseFirestore> {
  const FirebaseFirestoreProvider._(
      {required FirebaseFirestoreFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'firebaseFirestoreProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseFirestoreHash();

  @override
  String toString() {
    return r'firebaseFirestoreProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<FirebaseFirestore> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseFirestore create(Ref ref) {
    final argument = this.argument as String?;
    return firebaseFirestore(
      ref,
      database: argument,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFirestore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFirestore>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FirebaseFirestoreProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$firebaseFirestoreHash() => r'accc0cf4946ef2d030c0ba68f39acc1b55ebe330';

final class FirebaseFirestoreFamily extends $Family
    with $FunctionalFamilyOverride<FirebaseFirestore, String?> {
  const FirebaseFirestoreFamily._()
      : super(
          retry: null,
          name: r'firebaseFirestoreProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FirebaseFirestoreProvider call({
    String? database,
  }) =>
      FirebaseFirestoreProvider._(argument: database, from: this);

  @override
  String toString() => r'firebaseFirestoreProvider';
}

@ProviderFor(firestoreCollectionReference)
const firestoreCollectionReferenceProvider =
    FirestoreCollectionReferenceFamily._();

final class FirestoreCollectionReferenceProvider extends $FunctionalProvider<
        CollectionReference<Map<String, dynamic>>,
        CollectionReference<Map<String, dynamic>>,
        CollectionReference<Map<String, dynamic>>>
    with $Provider<CollectionReference<Map<String, dynamic>>> {
  const FirestoreCollectionReferenceProvider._(
      {required FirestoreCollectionReferenceFamily super.from,
      required (
        String, {
        String? database,
      })
          super.argument})
      : super(
          retry: null,
          name: r'firestoreCollectionReferenceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firestoreCollectionReferenceHash();

  @override
  String toString() {
    return r'firestoreCollectionReferenceProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<CollectionReference<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CollectionReference<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as (
      String, {
      String? database,
    });
    return firestoreCollectionReference(
      ref,
      argument.$1,
      database: argument.database,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionReference<Map<String, dynamic>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<CollectionReference<Map<String, dynamic>>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FirestoreCollectionReferenceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$firestoreCollectionReferenceHash() =>
    r'010b42b99d6ce348852151901b1f3b71b4fa1b68';

final class FirestoreCollectionReferenceFamily extends $Family
    with
        $FunctionalFamilyOverride<
            CollectionReference<Map<String, dynamic>>,
            (
              String, {
              String? database,
            })> {
  const FirestoreCollectionReferenceFamily._()
      : super(
          retry: null,
          name: r'firestoreCollectionReferenceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FirestoreCollectionReferenceProvider call(
    String path, {
    String? database,
  }) =>
      FirestoreCollectionReferenceProvider._(argument: (
        path,
        database: database,
      ), from: this);

  @override
  String toString() => r'firestoreCollectionReferenceProvider';
}

@ProviderFor(firestoreDocumentReference)
const firestoreDocumentReferenceProvider = FirestoreDocumentReferenceFamily._();

final class FirestoreDocumentReferenceProvider extends $FunctionalProvider<
        DocumentReference<Map<String, dynamic>>,
        DocumentReference<Map<String, dynamic>>,
        DocumentReference<Map<String, dynamic>>>
    with $Provider<DocumentReference<Map<String, dynamic>>> {
  const FirestoreDocumentReferenceProvider._(
      {required FirestoreDocumentReferenceFamily super.from,
      required (
        String, {
        String? database,
      })
          super.argument})
      : super(
          retry: null,
          name: r'firestoreDocumentReferenceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firestoreDocumentReferenceHash();

  @override
  String toString() {
    return r'firestoreDocumentReferenceProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<DocumentReference<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DocumentReference<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as (
      String, {
      String? database,
    });
    return firestoreDocumentReference(
      ref,
      argument.$1,
      database: argument.database,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DocumentReference<Map<String, dynamic>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<DocumentReference<Map<String, dynamic>>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FirestoreDocumentReferenceProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$firestoreDocumentReferenceHash() =>
    r'a835be2b9479bdc2645b1dc1ecce6dc722bcc464';

final class FirestoreDocumentReferenceFamily extends $Family
    with
        $FunctionalFamilyOverride<
            DocumentReference<Map<String, dynamic>>,
            (
              String, {
              String? database,
            })> {
  const FirestoreDocumentReferenceFamily._()
      : super(
          retry: null,
          name: r'firestoreDocumentReferenceProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FirestoreDocumentReferenceProvider call(
    String path, {
    String? database,
  }) =>
      FirestoreDocumentReferenceProvider._(argument: (
        path,
        database: database,
      ), from: this);

  @override
  String toString() => r'firestoreDocumentReferenceProvider';
}

@ProviderFor(firestoreDocument)
const firestoreDocumentProvider = FirestoreDocumentFamily._();

final class FirestoreDocumentProvider extends $FunctionalProvider<
        AsyncValue<DocumentSnapshot<Map<String, dynamic>>>,
        DocumentSnapshot<Map<String, dynamic>>,
        FutureOr<DocumentSnapshot<Map<String, dynamic>>>>
    with
        $FutureModifier<DocumentSnapshot<Map<String, dynamic>>>,
        $FutureProvider<DocumentSnapshot<Map<String, dynamic>>> {
  const FirestoreDocumentProvider._(
      {required FirestoreDocumentFamily super.from,
      required (
        String, {
        String? database,
      })
          super.argument})
      : super(
          retry: null,
          name: r'firestoreDocumentProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firestoreDocumentHash();

  @override
  String toString() {
    return r'firestoreDocumentProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<DocumentSnapshot<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<DocumentSnapshot<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as (
      String, {
      String? database,
    });
    return firestoreDocument(
      ref,
      argument.$1,
      database: argument.database,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FirestoreDocumentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$firestoreDocumentHash() => r'e3c0e02601f3cfdb0f637748b27f7398a662f8cd';

final class FirestoreDocumentFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<DocumentSnapshot<Map<String, dynamic>>>,
            (
              String, {
              String? database,
            })> {
  const FirestoreDocumentFamily._()
      : super(
          retry: null,
          name: r'firestoreDocumentProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FirestoreDocumentProvider call(
    String path, {
    String? database,
  }) =>
      FirestoreDocumentProvider._(argument: (
        path,
        database: database,
      ), from: this);

  @override
  String toString() => r'firestoreDocumentProvider';
}

@ProviderFor(firestoreDocumentStream)
const firestoreDocumentStreamProvider = FirestoreDocumentStreamFamily._();

final class FirestoreDocumentStreamProvider extends $FunctionalProvider<
        AsyncValue<DocumentSnapshot<Map<String, dynamic>>>,
        DocumentSnapshot<Map<String, dynamic>>,
        Stream<DocumentSnapshot<Map<String, dynamic>>>>
    with
        $FutureModifier<DocumentSnapshot<Map<String, dynamic>>>,
        $StreamProvider<DocumentSnapshot<Map<String, dynamic>>> {
  const FirestoreDocumentStreamProvider._(
      {required FirestoreDocumentStreamFamily super.from,
      required (
        String, {
        String? database,
      })
          super.argument})
      : super(
          retry: null,
          name: r'firestoreDocumentStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firestoreDocumentStreamHash();

  @override
  String toString() {
    return r'firestoreDocumentStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<DocumentSnapshot<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as (
      String, {
      String? database,
    });
    return firestoreDocumentStream(
      ref,
      argument.$1,
      database: argument.database,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FirestoreDocumentStreamProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$firestoreDocumentStreamHash() =>
    r'987bbcf2445d7a56ac4866c3c5cd0ae97d0b201f';

final class FirestoreDocumentStreamFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Stream<DocumentSnapshot<Map<String, dynamic>>>,
            (
              String, {
              String? database,
            })> {
  const FirestoreDocumentStreamFamily._()
      : super(
          retry: null,
          name: r'firestoreDocumentStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FirestoreDocumentStreamProvider call(
    String path, {
    String? database,
  }) =>
      FirestoreDocumentStreamProvider._(argument: (
        path,
        database: database,
      ), from: this);

  @override
  String toString() => r'firestoreDocumentStreamProvider';
}

@ProviderFor(firestoreQuery)
const firestoreQueryProvider = FirestoreQueryFamily._();

final class FirestoreQueryProvider extends $FunctionalProvider<
    Query<Map<String, dynamic>>,
    Query<Map<String, dynamic>>,
    Query<Map<String, dynamic>>> with $Provider<Query<Map<String, dynamic>>> {
  const FirestoreQueryProvider._(
      {required FirestoreQueryFamily super.from,
      required (
        String, {
        String? database,
        OrderBy? orderBy,
      })
          super.argument})
      : super(
          retry: null,
          name: r'firestoreQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firestoreQueryHash();

  @override
  String toString() {
    return r'firestoreQueryProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $ProviderElement<Query<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Query<Map<String, dynamic>> create(Ref ref) {
    final argument = this.argument as (
      String, {
      String? database,
      OrderBy? orderBy,
    });
    return firestoreQuery(
      ref,
      argument.$1,
      database: argument.database,
      orderBy: argument.orderBy,
    );
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Query<Map<String, dynamic>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Query<Map<String, dynamic>>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FirestoreQueryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$firestoreQueryHash() => r'5269637d22e5b48410a38d9057144727ba6022f6';

final class FirestoreQueryFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Query<Map<String, dynamic>>,
            (
              String, {
              String? database,
              OrderBy? orderBy,
            })> {
  const FirestoreQueryFamily._()
      : super(
          retry: null,
          name: r'firestoreQueryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FirestoreQueryProvider call(
    String collectionPath, {
    String? database,
    OrderBy? orderBy,
  }) =>
      FirestoreQueryProvider._(argument: (
        collectionPath,
        database: database,
        orderBy: orderBy,
      ), from: this);

  @override
  String toString() => r'firestoreQueryProvider';
}

@ProviderFor(firestoreQueryStream)
const firestoreQueryStreamProvider = FirestoreQueryStreamFamily._();

final class FirestoreQueryStreamProvider extends $FunctionalProvider<
        AsyncValue<QuerySnapshot<Map<String, dynamic>>>,
        QuerySnapshot<Map<String, dynamic>>,
        Stream<QuerySnapshot<Map<String, dynamic>>>>
    with
        $FutureModifier<QuerySnapshot<Map<String, dynamic>>>,
        $StreamProvider<QuerySnapshot<Map<String, dynamic>>> {
  const FirestoreQueryStreamProvider._(
      {required FirestoreQueryStreamFamily super.from,
      required (
        String, {
        String? database,
        OrderBy? orderBy,
      })
          super.argument})
      : super(
          retry: null,
          name: r'firestoreQueryStreamProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firestoreQueryStreamHash();

  @override
  String toString() {
    return r'firestoreQueryStreamProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<QuerySnapshot<Map<String, dynamic>>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> create(Ref ref) {
    final argument = this.argument as (
      String, {
      String? database,
      OrderBy? orderBy,
    });
    return firestoreQueryStream(
      ref,
      argument.$1,
      database: argument.database,
      orderBy: argument.orderBy,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FirestoreQueryStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$firestoreQueryStreamHash() =>
    r'e2a8b9dbe7ba0134b4bf0d989aeb9559203281d6';

final class FirestoreQueryStreamFamily extends $Family
    with
        $FunctionalFamilyOverride<
            Stream<QuerySnapshot<Map<String, dynamic>>>,
            (
              String, {
              String? database,
              OrderBy? orderBy,
            })> {
  const FirestoreQueryStreamFamily._()
      : super(
          retry: null,
          name: r'firestoreQueryStreamProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FirestoreQueryStreamProvider call(
    String collectionPath, {
    String? database,
    OrderBy? orderBy,
  }) =>
      FirestoreQueryStreamProvider._(argument: (
        collectionPath,
        database: database,
        orderBy: orderBy,
      ), from: this);

  @override
  String toString() => r'firestoreQueryStreamProvider';
}

@ProviderFor(firestoreQueryDocumentList)
const firestoreQueryDocumentListProvider = FirestoreQueryDocumentListFamily._();

final class FirestoreQueryDocumentListProvider extends $FunctionalProvider<
        AsyncValue<List<QueryDocumentSnapshot<Map<String, dynamic>>>>,
        List<QueryDocumentSnapshot<Map<String, dynamic>>>,
        FutureOr<List<QueryDocumentSnapshot<Map<String, dynamic>>>>>
    with
        $FutureModifier<List<QueryDocumentSnapshot<Map<String, dynamic>>>>,
        $FutureProvider<List<QueryDocumentSnapshot<Map<String, dynamic>>>> {
  const FirestoreQueryDocumentListProvider._(
      {required FirestoreQueryDocumentListFamily super.from,
      required (
        String, {
        String? database,
        OrderBy? orderBy,
      })
          super.argument})
      : super(
          retry: null,
          name: r'firestoreQueryDocumentListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firestoreQueryDocumentListHash();

  @override
  String toString() {
    return r'firestoreQueryDocumentListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      $createElement($ProviderPointer pointer) =>
          $FutureProviderElement(pointer);

  @override
  FutureOr<List<QueryDocumentSnapshot<Map<String, dynamic>>>> create(Ref ref) {
    final argument = this.argument as (
      String, {
      String? database,
      OrderBy? orderBy,
    });
    return firestoreQueryDocumentList(
      ref,
      argument.$1,
      database: argument.database,
      orderBy: argument.orderBy,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FirestoreQueryDocumentListProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$firestoreQueryDocumentListHash() =>
    r'e2e53ba5ec4ca7366665e5673e0b54a950706506';

final class FirestoreQueryDocumentListFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<List<QueryDocumentSnapshot<Map<String, dynamic>>>>,
            (
              String, {
              String? database,
              OrderBy? orderBy,
            })> {
  const FirestoreQueryDocumentListFamily._()
      : super(
          retry: null,
          name: r'firestoreQueryDocumentListProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  FirestoreQueryDocumentListProvider call(
    String collectionPath, {
    String? database,
    OrderBy? orderBy,
  }) =>
      FirestoreQueryDocumentListProvider._(argument: (
        collectionPath,
        database: database,
        orderBy: orderBy,
      ), from: this);

  @override
  String toString() => r'firestoreQueryDocumentListProvider';
}
