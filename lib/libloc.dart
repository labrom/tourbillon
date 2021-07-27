import 'package:tourbillon/loc.dart';

abstract class LibLocalizations {
  static final delegate = AppLocalizationsDelegate<_LibLocalizations>(
    values: {
      'tourbillon': {
        en: 'Whirlwind',
        fr: 'Tourbillon',
      },
    },
    builder: (locale, values) => _LibLocalizations(locale, values),
  );
}

class _LibLocalizations extends BaseLocalizations {
  _LibLocalizations(locale, values) : super(locale, values);

  String get tourbillon => get('tourbillon');
}
