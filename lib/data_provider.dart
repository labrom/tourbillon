import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'cache.dart';
import 'firestore.dart';

class DataProvider extends ChangeNotifier {
  final BuildContext _context;
  final Cache<DocumentSnapshot> _cache = Cache();

  final String path;

  final Query Function(CollectionReference)? queryModifier;

  List<DocumentSnapshot> get data => _cache.map.values.toList();

  DocumentSnapshot? document(String id) => _cache[id];

  DataProvider(
    this._context,
    this.path, {
    this.queryModifier,
  }) {
    _load();
  }

  void _load() async {
    final collection = firestoreProvider(_context).instance.collection(path);
    final query =
        queryModifier != null ? queryModifier!(collection) : collection;
    query.snapshots().listenUnique((snapshots) {
      _cache.setAllStale();
      for (var doc in snapshots.docs) {
        _cache[doc.id] = doc;
      }
      notifyListeners();
    }, key: path);
  }

  void delete(String docId) {
    _cache.setStale(docId);
    firestoreProvider(_context)
        .instance
        .collection(path)
        .doc(docId)
        .delete()
        .then((_) {
      _cache.remove(docId);
      notifyListeners();
    });
  }
}
