import 'package:flutter/widgets.dart';

import 'change_notifier_scope.dart';
import 'data_provider.dart';
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
      builder: (context, provider, _) {
        provider.load();
        return ListView.builder(
          itemCount: provider.data.length,
          itemBuilder: (context, index) =>
              Text(provider.data[index].getOrDefault('name', '')),
        );
      },
    );
  }
}
