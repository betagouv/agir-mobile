import 'package:sentry_flutter/sentry_flutter.dart';

abstract final class CrashReporting {
  static Future<void> init() => SentryFlutter.init((final p0) {});

  // ignore: unused-code
  static Future<void> captureException(
    final dynamic exception, {
    final dynamic stackTrace,
  }) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  }
}
