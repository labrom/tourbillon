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
