import 'package:flutter/material.dart';

import 'libloc.dart';

class EmailAddressInputForm extends StatefulWidget {
  final void Function(String emailAddress) onAddEmailAddress;

  const EmailAddressInputForm(
    this.onAddEmailAddress, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailAddressInputFormState();
}

class _EmailAddressInputFormState extends State<EmailAddressInputForm> {
  final RegExp _emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  bool _isValidEmailAddress = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() => _updateEmailAddressValidity());
    _isValidEmailAddress = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
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
            ),
          ),
          TextButton(
            child: Text(libloc(context).addButtonLabel),
            onPressed: _isValidEmailAddress ? () => _addEmailAddress() : null,
          ),
        ],
      );

  void _updateEmailAddressValidity() {
    var valid = _emailRegex.hasMatch(_controller.text);
    if (_isValidEmailAddress != valid) {
      setState(() {
        _isValidEmailAddress = valid;
      });
    }
  }

  void _addEmailAddress() {
    widget.onAddEmailAddress(_controller.text);
    _controller.clear();
  }
}
