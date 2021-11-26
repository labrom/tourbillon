import 'package:logger/logger.dart';

final log = Logger(
  level: Level
      .verbose, // level is used in debug mode only, nothing's logged in release mode
  printer: _Printer(),
);

class _Printer extends LogPrinter {
  @override
  List<String> log(LogEvent event) =>
      event.level == Level.error || event.level == Level.debug
          ? _logError(event)
          : ['${_levelPrefix[event.level]}: ${event.message}'];

  List<String> _logError(LogEvent event) {
    final lines = <String>[event.message];
    if (event.error != null) {
      lines.add(event.error.toString());
    }
    if (event.stackTrace != null) {
      lines.add(event.stackTrace.toString());
    }
    return lines;
  }
}

const _levelPrefix = {
  Level.debug: 'D',
  Level.error: 'E',
  Level.info: 'I',
  Level.verbose: 'V',
  Level.warning: 'W',
  Level.wtf: 'WTF',
};
