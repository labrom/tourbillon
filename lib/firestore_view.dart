import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import 'change_notifier_scope.dart';
import 'data_provider.dart';
import 'firestore.dart';

/// A list widget that displays documents from a Firestore collection.
class FirestoreView extends StatelessWidget {
  /// The path to the Firestore collection displayed by this list widget.
  final String path;

  /// Function that builds a Widget for each list item.
  final Widget Function(BuildContext, DocumentSnapshot) itemBuilder;

  /// Function that allows to filter, limit, or order the document collection.
  final Query Function(CollectionReference)? queryModifier;

  /// Callback function that is invoked when a list item is selected. The
  /// parameter is the item's Firestore document ID.
  final void Function(String)? onItemSelected;

  FirestoreView(
    this.path, {
    required this.itemBuilder,
    this.queryModifier,
    this.onItemSelected,
    Key? key,
  }) : super(key: key);

  FirestoreView.basicName(
    String path, {
    Query Function(CollectionReference)? queryModifier,
    Key? key,
  }) : this(
          path,
          itemBuilder: _ListItem.builder,
          queryModifier: queryModifier,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierScope<DataProvider>(
      (_) => DataProvider(
        context,
        path,
        queryModifier: queryModifier,
      ),
      builder: (context, provider, _) => ListView.builder(
        itemCount: provider.data.length,
        itemBuilder: (context, index) => onItemSelected != null
            ? _ClickHandler(() => onItemSelected!(provider.data[index].id),
                child: itemBuilder(context, provider.data[index]))
            : itemBuilder(context, provider.data[index]),
      ),
    );
  }
}

class FirestoreStreamView extends StatefulWidget {
  /// The path to the Firestore collection displayed by this list widget.
  final String path;

  /// Function that builds a Widget for each list item.
  final Widget Function(BuildContext, DocumentSnapshot) itemBuilder;

  /// Function that allows to filter, limit, or order the document collection.
  final Query Function(CollectionReference)? queryModifier;

  /// Callback function that is invoked when a list item is selected. The
  /// parameter is the item's Firestore document ID.
  final void Function(String)? onItemSelected;

  FirestoreStreamView(
    this.path, {
    required this.itemBuilder,
    this.queryModifier,
    this.onItemSelected,
    Key? key,
  }) : super(key: key);

  FirestoreStreamView.basicName(
    String path, {
    Query Function(CollectionReference)? queryModifier,
    Key? key,
  }) : this(
          path,
          itemBuilder: _ListItem.builder,
          queryModifier: queryModifier,
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _FirestoreStreamViewState();
}

class _FirestoreStreamViewState extends State<FirestoreStreamView> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    var collection =
        firestoreProvider(context).instance.collection(widget.path);
    var query = widget.queryModifier != null
        ? widget.queryModifier!(collection)
        : collection;
    _stream = query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (context, snapshot) => ListView.builder(
          itemCount: snapshot.data?.size ?? 0,
          itemBuilder: (context, index) => widget.onItemSelected != null
              ? _ClickHandler(
                  () => widget.onItemSelected!(snapshot.data!.docs[index].id),
                  child:
                      widget.itemBuilder(context, snapshot.data!.docs[index]),
                )
              : widget.itemBuilder(context, snapshot.data!.docs[index])),
    );
  }
}

class _ClickHandler extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const _ClickHandler(this.onTap, {required this.child});

  @override
  Widget build(BuildContext context) =>
      GestureDetector(onTap: onTap, child: child);
}

class _ListItem extends StatelessWidget {
  static final Widget Function(BuildContext, DocumentSnapshot) builder =
      (_, snapshot) => _ListItem(snapshot);

  final DocumentSnapshot doc;

  _ListItem(this.doc);

  @override
  Widget build(BuildContext context) => Text(doc.getOrDefault('name', ''));
}
