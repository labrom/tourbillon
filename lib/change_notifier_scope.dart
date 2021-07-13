import 'package:flutter/widgets.dart';
import 'package:pono/log.dart';
import 'package:provider/provider.dart';

/// A widget that gives all widgets under itself access to a [ChangeNotifier].
///
/// It is OK to use this widget anywhere in the widget tree, as it will create
/// a [ChangeNotifierProvider] only if it cannot find one in its parent tree.
/// If an instance of this widget is used in the parent tree, no new [ChangeNotifierProvider]
/// is created.
class ChangeNotifierScope<CN extends ChangeNotifier> extends StatelessWidget {
  final Widget? child;
  final CN Function(BuildContext context) create;
  final ChangeNotifierBuilder<CN> builder;

  ChangeNotifierScope(
    this.create, {
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    try {
      var changeNotifier = Provider.of<CN>(context, listen: false);
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

typedef ChangeNotifierBuilder<CN extends ChangeNotifier> = Function(
    BuildContext context, CN notifier, Widget? child);
