import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const en = 'en';
const fr = 'fr';

/// Function that gives access to a localization instance of a specified type.
L loc<L extends BaseLocalizations>(BuildContext context) {
  final loc = Localizations.of<L>(context, L);
  if (loc == null) {
    throw 'Localizations class $L must be registered.';
  }
  return loc;
}

/// Class that can be extended to build a localization class for an app or
/// a library.
///
/// Instances of this class are built by a function provided in the constructor
/// of [AppLocalizationsDelegate].
/// Typically these classes give easy member access to localized strings.
/// These classes can also give access to a unique AppLocalizationsDelegate]
/// instance.
///
/// Example:
///
/// ```dart
/// MaterialApp(
///   localizationsDelegates: [
///     MyLocalizations.delegate,
///   ],
/// )
///
/// class MyLocalizations extends BaseLocalizations {
///
///   static final delegate = AppLocalizationsDelegate<MyLocalizations>(
///     values: {
///       'hello': {
///         'en': 'Hello',
///         'fr': 'Bonjour',
///       },
///       'goodbye': {
///         'en': 'Goodbye',
///         'fr': 'Au revoir',
///       },
///       'seeYouInDays': {
///         'en': 'See you in {} days',
///         'fr': 'Nous nous reverrons dans {} jours',
///       },
///       'greetNames': {
///         'en': 'Hi {name1}, how is {name2}?',
///         'fr': 'Bonjour {name1}, comment va {name2}?',
///       },
///     },
///     builder: (locale, values) => _LibLocalizations(locale, values),
///   );
///
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
class BaseLocalizations {
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
///     AppLocalizationsDelegate<MyLocDelegate>(
///       builder: (locale, values) => MyLocDelegate(locale, values),
///     ),
///   ],
/// )
/// ```
///
/// Localized values must be provided in the form of a map of maps, with keys
/// being the string key names, and values being a map of string values
/// mapped by language code. For example:
/// ```dart
/// values: {
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
/// }
/// ```
class AppLocalizationsDelegate<L extends BaseLocalizations>
    extends LocalizationsDelegate<L> {
  final L Function(Locale, Map<String, Map<String, String>>) builder;
  final List<String> supportedLocales;
  final Map<String, Map<String, String>> _values;

  const AppLocalizationsDelegate({
    required Map<String, Map<String, String>> values,
    required this.builder,
    this.supportedLocales = const [en, fr],
  }) : _values = values;

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.contains(locale.languageCode);

  @override
  Future<L> load(Locale locale) {
    return SynchronousFuture<L>(builder(locale, _values));
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

  String withParam(dynamic value) => replaceAll('{}', '$value')
      .replaceAll(RegExp('{[a-zA-Z0-9._-]+}'), '$value');
}
