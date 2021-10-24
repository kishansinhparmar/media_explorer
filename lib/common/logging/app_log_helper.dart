import 'dart:developer' as developer;

class SLog {
  static void sLog(String message, {Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      error: error,
      stackTrace: stackTrace,
      // level: Level.SEVERE.value,
    );
  }
}
