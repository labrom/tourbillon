import 'package:flutter/widgets.dart';
import 'package:pono/change_notifier_scope.dart';
import 'package:pono/data_provider.dart';

import 'firestore.dart';

class FirestoreView extends StatelessWidget {
  final String path;

  const FirestoreView(
    this.path, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierScope<DataProvider>(
      (_) => DataProvider(path),
      builder: (context, provider, _) => ListView.builder(
        itemBuilder: (context, index) =>
            Text(provider.data[index].getOrDefault('name', '')),
      ),
    );
  }
}
