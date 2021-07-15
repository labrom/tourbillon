import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'change_notifier_scope.dart';
import 'data_provider.dart';
import 'firestore.dart';

class FirestoreView extends StatelessWidget {
  final String path;
  final Widget Function(BuildContext, DocumentSnapshot) itemBuilder;

  FirestoreView(
    this.path, {
    required this.itemBuilder,
    Key? key,
  }) : super(key: key);

  FirestoreView.basicName(String path, {Key? key})
      : this(path, itemBuilder: (_, snapshot) => _ListItem(snapshot), key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierScope<DataProvider>(
      (_) => DataProvider(context, path),
      builder: (context, provider, _) => ListView.builder(
        itemCount: provider.data.length,
        itemBuilder: (context, index) =>
            itemBuilder(context, provider.data[index]),
      ),
    );
  }
}

class FirestoreStreamView extends StatefulWidget {
  final String path;
  final Widget Function(BuildContext, DocumentSnapshot) itemBuilder;

  FirestoreStreamView(
    this.path, {
    required this.itemBuilder,
    Key? key,
  }) : super(key: key);

  FirestoreStreamView.basicName(String path, {Key? key})
      : this(path, itemBuilder: (_, snapshot) => _ListItem(snapshot), key: key);

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
        itemCount: snapshot.data?.size ?? 0,
        itemBuilder: (context, index) =>
            widget.itemBuilder(context, snapshot.data!.docs[index]),
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
