import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'log.dart';

/// A widget that gives all widgets under itself access to a [ChangeNotifier].
///
/// It is OK to use this widget anywhere in the widget tree, as it will create
/// a [ChangeNotifierProvider] only if it cannot find one in its parent tree.
/// If an instance of this widget is used in the parent tree, no new [ChangeNotifierProvider]
/// is created.
class ChangeNotifierScope<CN extends ChangeNotifier> extends StatelessWidget {
  final Widget? child;
  final CN Function(BuildContext context) create;
  final ChangeNotifierConsumerBuilder<CN> builder;

  const ChangeNotifierScope(
    this.create, {
    required this.builder,
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      var changeNotifier = Provider.of<CN>(context);
      return builder(context, changeNotifier, child);
    } on ProviderNotFoundException {
      log.d('Found no instance of $CN, creating one');
      return ChangeNotifierProvider<CN>(
        create: create,
        child: Consumer<CN>(
          builder: (context, changeNotifier, child) =>
              builder(context, changeNotifier, child),
          child: child,
        ),
      );
    }
  }
}

/// A function that builds a consumer widget for the [ChangeNotifier].
typedef ChangeNotifierConsumerBuilder<CN extends ChangeNotifier> = Function(
    BuildContext context, CN notifier, Widget? child);
