import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'firestore.dart';

class DataProvider extends ChangeNotifier {
  final String path;
  final BuildContext _context;

  final Query Function(CollectionReference)? queryModifier;

  List<DocumentSnapshot> data = [];

  DataProvider(
    this._context,
    this.path, {
    this.queryModifier,
  }) {
    _load();
  }

  void _load() async {
    var collection = firestoreProvider(_context).instance.collection(path);
    var query = queryModifier != null ? queryModifier!(collection) : collection;
    query.snapshots().listenUnique((snapshots) {
      data = snapshots.docs;
      notifyListeners();
    }, key: path);
  }
}
