import 'package:flutter/material.dart';

import 'libloc.dart';

/// A widget that displays a text input field for email addresses.
///
/// The widget can be displayed with or without an Add button that allows
/// to send the valid email address input to the [onAddEmailAddress] function.
/// In this case, the button id displayed on the same line as the text input, on
/// the `end` side.
/// When the Add button is pressed, the text input field is cleared.
/// Irrespective of the presence or absence of the Add button, the
/// [onEmailAddressValidityChanged] function, if provided, will be invoked
/// whenever the typed-in email address validity changes, with the content of
/// the input field.
/// The text input is initially empty, and validity is `false`, so the first
/// call to [onEmailAddressValidityChanged] will only happen when the typed-in
/// address becomes valid.
/// If the Add button is present, [onEmailAddressValidityChanged] will be
/// invoked with the value `false` when the button is tapped, and the field is
/// emptied.
class EmailAddressInputForm extends StatefulWidget {
  /// Callback function that is invoked when the Add button is tapped.
  final void Function(String emailAddress)? onAddEmailAddress;

  /// Callback function that is invoked when the typed-in address becomes
  /// valid or invalid.
  ///
  /// This function is useful when external components need to update some UI
  /// based on what the user typed into the input field.
  final void Function(String input, bool valid)? onEmailAddressValidityChanged;

  final TextEditingController? controller;

  const EmailAddressInputForm(
    this.onAddEmailAddress, {
    this.onEmailAddressValidityChanged,
    Key? key,
  })  : controller = null,
        super(key: key);

  const EmailAddressInputForm.withoutAddButton({
    required void Function(String input, bool valid)
        onEmailAddressValidityChanged,
    required this.controller,
    Key? key,
  })  : onAddEmailAddress = null,
        // ignore: prefer_initializing_formals
        onEmailAddressValidityChanged = onEmailAddressValidityChanged,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailAddressInputFormState();
}

class _EmailAddressInputFormState extends State<EmailAddressInputForm> {
  static final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  bool _isValidEmailAddress = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = (widget.controller ?? TextEditingController())
      ..addListener(_updateEmailAddressValidity);
    _isValidEmailAddress = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.onAddEmailAddress != null
      ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _textFormField(),
            ),
            TextButton(
              child: Text(libloc(context).addButtonLabel),
              onPressed: _isValidEmailAddress ? () => _addEmailAddress() : null,
            ),
          ],
        )
      : _textFormField();

  Widget _textFormField() => TextFormField(
        decoration: InputDecoration(
          labelText: libloc(context).emailAddress,
          icon: Icon(Icons.email),
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.send,
        controller: _controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enableSuggestions: false,
        autocorrect: false,
        autofocus: true,
        validator: (email) => _emailRegex.hasMatch(email ?? '')
            ? null
            : libloc(context).enterValidEmailAddressMessage,
        onFieldSubmitted: (_) {
          if (_isValidEmailAddress) _addEmailAddress();
        },
      );

  void _updateEmailAddressValidity() {
    var valid = _emailRegex.hasMatch(_controller.text);
    if (_isValidEmailAddress != valid) {
      setState(() {
        _isValidEmailAddress = valid;
      });
      widget.onEmailAddressValidityChanged?.call(_controller.text, valid);
    }
  }

  void _addEmailAddress() {
    widget.onAddEmailAddress?.call(_controller.text);
    _clearInput();
  }

  void _clearInput() {
    _controller.removeListener(_updateEmailAddressValidity);
    _controller.clear();
    _controller.addListener(_updateEmailAddressValidity);
    setState(() {
      _isValidEmailAddress = false;
    });
  }
}
