import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'firestore.dart';

class DataProvider extends ChangeNotifier {
  final String path;
  List<DocumentSnapshot> data = [];

  DataProvider(this.path);

  void load() async {
    FirebaseFirestore.instance.collection(path).snapshots().listenUnique(
        (snapshots) {
      data = snapshots.docs;
      notifyListeners();
    }, key: path);
  }
}
