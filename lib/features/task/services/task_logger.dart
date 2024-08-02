import 'package:intl/intl.dart';

class TaskLogger {
  static void info(String message) {
    _log('INFO', message, 'blue');
  }

  static void warn(String message) {
    _log('WARN', message, 'yellow');
  }

  static void error(String message) {
    _log('ERROR', message, 'red');
  }

  static void _log(String level, String message, String color) {
    final timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    final formattedMessage = '[${level.padRight(5)}] $timestamp: $message';
    
    final colorCode = _getColorCode(color);

    print('$colorCode$formattedMessage\x1B[0m');
  }

  static String _getColorCode(String color) {
    switch (color) {
      case 'blue':
        return '\x1B[34m';
      case 'yellow':
        return '\x1B[33m';
      case 'red':
        return '\x1B[31m';
      default:
        return '\x1B[0m';
    }
  }
}
