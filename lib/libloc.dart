import 'package:flutter/widgets.dart';
import 'package:tourbillon/loc.dart';

LibLocalizations libloc(BuildContext context) => loc<LibLocalizations>(context);

class LibLocalizations extends BaseLocalizations {
  static final delegate = AppLocalizationsDelegate<LibLocalizations>(
    values: {
      'addButtonLabel': {
        en: 'ADD',
        fr: 'AJOUTER',
      },
      'emailAddress': {
        en: 'Email address',
        fr: 'Address électronique',
      },
      'emailLabel': {
        en: 'Email',
        fr: 'Mél.',
      },
      'enterValidEmailAddressMessage': {
        en: 'Enter a valid email address.',
        fr: 'Entrez une adresse email valide.',
      },
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

  String get addButtonLabel => get('addButtonLabel');
  String get emailAddress => get('emailAddress');
  String get emailLabel => get('emailLabel');
  String get enterValidEmailAddressMessage =>
      get('enterValidEmailAddressMessage');
  String get noButtonLabel => get('noButtonLabel');
  String get yesButtonLabel => get('yesButtonLabel');
}
