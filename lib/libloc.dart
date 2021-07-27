import 'dart:ui';

import 'package:tourbillon/loc.dart';

abstract class LibLocalizations {
  static final delegate =
      AppLocalizationsDelegate(builder: (locale) => _LibLocalizations(locale));
}

class _LibLocalizations extends BaseLocalizations {
  _LibLocalizations(Locale locale) : super(locale, _values);

  String get tourbillon => get('tourbillon');
}

const Map<String, Map<String, String>> _values = {
  'tourbillon': {
    en: 'Whirlwind',
    fr: 'Tourbillon',
  },
};
