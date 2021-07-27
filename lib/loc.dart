import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const en = 'en';
const fr = 'fr';

/// Function that gives access to a localization instance of a specified type.
L loc<L extends BaseLocalizations>(BuildContext context) =>
    Localizations.of<L>(context, L)!;

/// Class that can be extended to build a localization class for an app or
/// a library.
///
/// Child classes must provide localized values in the form of a map of maps,
/// with keys being the string key names, and values being a map of string values
/// mapped by language code.
/// For example:
/// ```dart
/// const Map<String, Map<String, String>> _values = {
///   'hello': {
///     'en': 'Hello',
///     'fr': 'Bonjour',
///   },
///   'goodbye': {
///     'en': 'Goodbye',
///     'fr': 'Au revoir',
///   },
///   'seeYouInDays': {
///     'en': 'See you in {} days',
///     'fr': 'Nous nous reverrons dans {} jours',
///   },
///   'greetNames': {
///     'en': 'Hi {name1}, how is {name2}?',
///     'fr': 'Bonjour {name1}, comment va {name2}?',
///   },
/// };
///
/// class MyLocalizations extends BaseLocalizations {
///   MyLocalizations(Locale locale) : super(locale, _values);
///
///   String get hello => get('hello');
///
///   String get goodbye => get('goodbye');
///
///   String seeYouInDays(int days) => get('seeYouInDays').withParam(days);
///
///   String greetNames(String name1, String name2) => get('greetNames').withParams({
///     'name1': name1,
///     'name2: name2,
///   });
/// }
/// ```
abstract class BaseLocalizations {
  final Locale locale;
  final Map<String, Map<String, String>> _values;

  BaseLocalizations(this.locale, this._values);

  String get(String key) =>
      _values[key]?[locale.languageCode] ?? _values[key]?[en] ?? '';
}

/// A localization delegate that can be used to register a specific child
/// class instance of [BaseLocalizations].
///
/// For example:
/// ```dart
/// MaterialApp(
///   localizationsDelegates: [
///     AppLocalizationsDelegate<MyLocDelegate>(builder: (locale) => MyLocDelegate(locale)),
///   ],
/// )
/// ```
class AppLocalizationsDelegate<L extends BaseLocalizations>
    extends LocalizationsDelegate<L> {
  final L Function(Locale) builder;
  final List<String> supportedLocales;

  const AppLocalizationsDelegate({
    required this.builder,
    this.supportedLocales = const [en, fr],
  });

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.contains(locale.languageCode);

  @override
  Future<L> load(Locale locale) {
    return SynchronousFuture<L>(builder(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate<L> old) => false;
}

extension Interpolation on String {
  String withParams(Map<String, dynamic> params) {
    var interpolated = this;
    for (var entry in params.entries) {
      interpolated =
          interpolated.replaceAll('{${entry.key}}', '${entry.value}');
    }
    return interpolated;
  }

  String withParam(dynamic value) => this
      .replaceAll('{}', '$value')
      .replaceAll(RegExp('\{[a-zA-Z0-9]+\}'), '$value');
}
