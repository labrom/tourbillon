import 'package:flutter/widgets.dart';
import 'package:tourbillon/loc.dart';

LibLocalizations libloc(BuildContext context) => loc<LibLocalizations>(context);

class LibLocalizations extends BaseLocalizations {
  static final delegate = AppLocalizationsDelegate<LibLocalizations>(
    values: {
      'accountSettingsMenu': {
        en: 'Account settings',
        fr: 'Paramètres du compte',
      },
      'noButtonLabel': {
        en: 'NO',
        fr: 'NON',
      },
      'signInButtonLabel': {
        en: 'SIGN IN',
        fr: 'SE CONNECTER',
      },
      'signOutButtonLabel': {
        en: 'SIGN OUT',
        fr: 'SE DÉCONNECTER',
      },
      'yesButtonLabel': {
        en: 'YES',
        fr: 'OUI',
      },
    },
    builder: (locale, values) => LibLocalizations._(locale, values),
  );

  LibLocalizations._(locale, values) : super(locale, values);

  String get accountSettingsMenu => get('accountSettingsMenu');
  String get noButtonLabel => get('noButtonLabel');
  String get signInButtonLabel => get('signInButtonLabel');
  String get signOutButtonLabel => get('signOutButtonLabel');
  String get yesButtonLabel => get('yesButtonLabel');
}
