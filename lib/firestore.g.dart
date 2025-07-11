// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firebaseFirestoreHash() => r'accc0cf4946ef2d030c0ba68f39acc1b55ebe330';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [firebaseFirestore].
@ProviderFor(firebaseFirestore)
const firebaseFirestoreProvider = FirebaseFirestoreFamily();

/// See also [firebaseFirestore].
class FirebaseFirestoreFamily extends Family<FirebaseFirestore> {
  /// See also [firebaseFirestore].
  const FirebaseFirestoreFamily();

  /// See also [firebaseFirestore].
  FirebaseFirestoreProvider call({
    String? database,
  }) {
    return FirebaseFirestoreProvider(
      database: database,
    );
  }

  @override
  FirebaseFirestoreProvider getProviderOverride(
    covariant FirebaseFirestoreProvider provider,
  ) {
    return call(
      database: provider.database,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'firebaseFirestoreProvider';
}

/// See also [firebaseFirestore].
class FirebaseFirestoreProvider extends AutoDisposeProvider<FirebaseFirestore> {
  /// See also [firebaseFirestore].
  FirebaseFirestoreProvider({
    String? database,
  }) : this._internal(
          (ref) => firebaseFirestore(
            ref as FirebaseFirestoreRef,
            database: database,
          ),
          from: firebaseFirestoreProvider,
          name: r'firebaseFirestoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$firebaseFirestoreHash,
          dependencies: FirebaseFirestoreFamily._dependencies,
          allTransitiveDependencies:
              FirebaseFirestoreFamily._allTransitiveDependencies,
          database: database,
        );

  FirebaseFirestoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.database,
  }) : super.internal();

  final String? database;

  @override
  Override overrideWith(
    FirebaseFirestore Function(FirebaseFirestoreRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FirebaseFirestoreProvider._internal(
        (ref) => create(ref as FirebaseFirestoreRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        database: database,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<FirebaseFirestore> createElement() {
    return _FirebaseFirestoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FirebaseFirestoreProvider && other.database == database;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, database.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FirebaseFirestoreRef on AutoDisposeProviderRef<FirebaseFirestore> {
  /// The parameter `database` of this provider.
  String? get database;
}

class _FirebaseFirestoreProviderElement
    extends AutoDisposeProviderElement<FirebaseFirestore>
    with FirebaseFirestoreRef {
  _FirebaseFirestoreProviderElement(super.provider);

  @override
  String? get database => (origin as FirebaseFirestoreProvider).database;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
