import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'firestore.dart';

class DataProvider extends ChangeNotifier {
  final String path;
  bool _loaded = false;

  List<DocumentSnapshot> data = [];

  DataProvider(this.path);

  void load() async {
    if (_loaded) return;
    _loaded = true;
    FirebaseFirestore.instance.collection(path).snapshots().listenUnique(
        (snapshots) {
      data = snapshots.docs;
      notifyListeners();
    }, key: path);
  }
}
