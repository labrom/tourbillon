import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'firestore.dart';

class DataProvider extends ChangeNotifier {
  final String path;
  final BuildContext _context;

  List<DocumentSnapshot> data = [];

  DataProvider(this._context, this.path) {
    _load();
  }

  void _load() async {
    firestoreProvider(_context)
        .instance
        .collection(path)
        .snapshots()
        .listenUnique((snapshots) {
      data = snapshots.docs;
      notifyListeners();
    }, key: path);
  }
}
