import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract final class CrashReportingWrapper {
  static Future<void> init() => SentryFlutter.init((final p0) {});

  // ignore: unused-code
  static Future<void> captureException(
    final dynamic exception, {
    final dynamic stackTrace,
  }) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  }

  static RouteObserver<PageRoute<dynamic>> getNavigatorObserver() =>
      SentryNavigatorObserver();
}
