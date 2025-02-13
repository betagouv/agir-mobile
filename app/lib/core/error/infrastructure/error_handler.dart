import 'dart:async';

import 'package:app/core/error/infrastructure/crash_reporting.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract final class ErrorHandler {
  static Future<void> register() async {
    if (!kDebugMode) {
      await CrashReporting.init();
    }
    _setupFlutterErrorHandling();
    _setupPlatformDispatcherErrorHandling();
    _setupErrorWidgetBuilder();
  }

  static void _setupFlutterErrorHandling() {
    FlutterError.onError = (final details) {
      FlutterError.presentError(details);
      captureException(details.exception, details.stack);
    };
  }

  static void _setupPlatformDispatcherErrorHandling() {
    PlatformDispatcher.instance.onError = (final error, final stack) {
      captureException(error, stack);

      return true;
    };
  }

  static void _setupErrorWidgetBuilder() {
    ErrorWidget.builder = (final details) {
      captureException(details.exception, details.stack);

      return _buildErrorWidget(details);
    };
  }

  static void captureException(final Object error, final StackTrace? stack) {
    debugPrint('Error: $error${stack == null ? '' : '\n$stack'}');
    unawaited(CrashReporting.captureException(error, stackTrace: stack));
  }

  static Widget _buildErrorWidget(final FlutterErrorDetails details) => MaterialApp(
    home: FnvScaffold(
      appBar: AppBar(title: const Text(Localisation.erreurInattendue), backgroundColor: FnvColors.appBarFond),
      body: Padding(padding: const EdgeInsets.all(paddingVerticalPage), child: Center(child: Text(details.exceptionAsString()))),
    ),
  );
}
