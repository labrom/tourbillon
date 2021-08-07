import 'package:flutter/widgets.dart';
import 'package:tourbillon/loc.dart';

LibLocalizations libloc(BuildContext context) => loc<LibLocalizations>(context);

class LibLocalizations extends BaseLocalizations {
  static final delegate = AppLocalizationsDelegate<LibLocalizations>(
    values: {
      'noButtonLabel': {
        en: 'NO',
        fr: 'NON',
      },
      'yesButtonLabel': {
        en: 'YES',
        fr: 'OUI',
      },
    },
    builder: (locale, values) => LibLocalizations._(locale, values),
  );

  LibLocalizations._(locale, values) : super(locale, values);

  String get noButtonLabel => get('noButtonLabel');
  String get yesButtonLabel => get('yesButtonLabel');
}
