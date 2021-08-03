import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourbillon/libloc.dart';

class TextInputDialog {
  final String title;
  final String textFieldLabel;
  final String? defaultValue;
  final String? positiveButton;
  final String? negativeButton;
  final bool allowEmpty;

  TextInputDialog({
    required this.title,
    required this.textFieldLabel,
    this.defaultValue,
    this.positiveButton,
    this.negativeButton,
    this.allowEmpty = false,
  });

  Future<String?> show(BuildContext context) => showDialog<String>(
        context: context,
        builder: _builder,
      );

  WidgetBuilder get _builder => (context) {
        var controller = TextEditingController(text: defaultValue);
        return ListenableProvider.value(
          value: controller,
          builder: (context, _) => AlertDialog(
            title: Text(title),
            content: TextFormField(
              decoration: InputDecoration(
                labelText: textFieldLabel,
              ),
              controller: controller,
              autofocus: true,
              onFieldSubmitted: (_) {
                if (allowEmpty ||
                    Provider.of<TextEditingController>(context, listen: false)
                        .text
                        .trim()
                        .isNotEmpty) {
                  Navigator.pop(
                      context,
                      Provider.of<TextEditingController>(context, listen: false)
                          .text
                          .trim());
                }
              },
            ),
            actions: [
              TextButton(
                child: Text(negativeButton ??
                    MaterialLocalizations.of(context).cancelButtonLabel),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text(positiveButton ??
                    MaterialLocalizations.of(context).okButtonLabel),
                onPressed: !allowEmpty &&
                        Provider.of<TextEditingController>(context)
                            .text
                            .trim()
                            .isEmpty
                    ? null
                    : () => Navigator.pop(
                          context,
                          Provider.of<TextEditingController>(context,
                                  listen: false)
                              .text
                              .trim(),
                        ),
              ),
            ],
          ),
        );
      };
}

class ConfirmDialog {
  final String title;
  final String? body;
  final String? positiveButton;
  final String? negativeButton;

  ConfirmDialog({
    required this.title,
    this.body,
    this.positiveButton,
    this.negativeButton,
  });
  Future<bool> show(BuildContext context) => showDialog<bool>(
        context: context,
        builder: _builder,
      ) as Future<bool>;

  WidgetBuilder get _builder => (context) => AlertDialog(
        title: Text(title),
        content: body != null ? Text(body!) : null,
        actions: [
          TextButton(
            child: Text(negativeButton ?? libloc(context).noButtonLabel),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text(positiveButton ?? libloc(context).yesButtonLabel),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      );
}
