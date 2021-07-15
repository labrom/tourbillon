import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'change_notifier_scope.dart';
import 'data_provider.dart';
import 'firestore.dart';

class FirestoreView extends StatelessWidget {
  final String path;

  FirestoreView(
    this.path, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierScope<DataProvider>(
      (_) => DataProvider(context, path),
      builder: (context, provider, _) => ListView.builder(
        itemCount: provider.data.length,
        itemBuilder: (context, index) => _ListItem(provider.data[index]),
      ),
    );
  }
}

class FirestoreStreamView extends StatefulWidget {
  final String path;

  FirestoreStreamView(
    this.path, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirestoreStreamViewState();
}

class _FirestoreStreamViewState extends State<FirestoreStreamView> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream =
        firestoreProvider(context).instance.collection(widget.path).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (context, snapshot) => ListView.builder(
        itemCount: snapshot.data!.size,
        itemBuilder: (context, index) => _ListItem(snapshot.data!.docs[index]),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final DocumentSnapshot doc;

  _ListItem(this.doc);

  @override
  Widget build(BuildContext context) => Text(doc.getOrDefault('name', ''));
}
