import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  const FirestoreView(
    this.path, {
    required this.itemBuilder,
    this.queryModifier,
    this.onItemSelected,
    Key? key,
  }) : super(key: key);

  const FirestoreView.basicName(
    String path, {
    Query Function(CollectionReference)? queryModifier,
    Key? key,
  }) : this(
          path,
          itemBuilder: _ListItem.builder,
          queryModifier: queryModifier,
          key: key,
        );

  FirestoreView.tile(
    String path, {
    Query Function(CollectionReference)? queryModifier,
    required String titleField,
    String? subtitleField,
    bool dense = false,
    bool isThreeLine = false,
    Key? key,
  }) : this(
          path,
          itemBuilder: (_, doc) => _TileListItem(
            doc,
            titleField: titleField,
            subtitleField: subtitleField,
            dense: dense,
            isThreeLine: isThreeLine,
          ),
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

  const FirestoreStreamView(
    this.path, {
    required this.itemBuilder,
    this.queryModifier,
    this.onItemSelected,
    Key? key,
  }) : super(key: key);

  const FirestoreStreamView.basicName(
    String path, {
    Query Function(CollectionReference)? queryModifier,
    Key? key,
  }) : this(
          path,
          itemBuilder: _ListItem.builder,
          queryModifier: queryModifier,
          key: key,
        );

  FirestoreStreamView.tile(
    String path, {
    Query Function(CollectionReference)? queryModifier,
    required String titleField,
    String? subtitleField,
    bool dense = false,
    bool isThreeLine = false,
    Key? key,
  }) : this(
          path,
          itemBuilder: (_, doc) => _TileListItem(
            doc,
            titleField: titleField,
            subtitleField: subtitleField,
            dense: dense,
            isThreeLine: isThreeLine,
          ),
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
  static Widget builder(BuildContext context, DocumentSnapshot snapshot) =>
      _ListItem(snapshot);

  final DocumentSnapshot doc;

  const _ListItem(this.doc);

  @override
  Widget build(BuildContext context) => Text(doc.getOrDefault('name', ''));
}

class _TileListItem extends StatelessWidget {
  final DocumentSnapshot doc;
  final String titleField;
  final String? subtitleField;
  final bool dense;
  final bool isThreeLine;

  const _TileListItem(
    this.doc, {
    required this.titleField,
    this.subtitleField,
    this.dense = false,
    this.isThreeLine = false,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(doc.getOrDefaultString(titleField, '')),
        subtitle: subtitleField != null
            ? Text(doc.getOrDefaultString(subtitleField!, ''))
            : null,
        dense: dense,
        isThreeLine: isThreeLine,
      );
}
