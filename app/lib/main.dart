import 'dart:async';

import 'package:app/app/app_setup.dart';
import 'package:app/core/error/infrastructure/crash_reporting.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  final widgetsBinding = SentryWidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  if (!kDebugMode) {
    await CrashReporting.init();
  }

  _registerErrorHandlers();

  runApp(const AppSetup());
}

void _registerErrorHandlers() {
  FlutterError.onError = (final details) {
    FlutterError.presentError(details);
    _captureException(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (final error, final stack) {
    _captureException(error, stack);

    return true;
  };

  ErrorWidget.builder = (final details) {
    _captureException(details.exception, details.stack);

    return MaterialApp(
      home: FnvScaffold(
        appBar: AppBar(
          title: const Text(Localisation.erreurInattendue),
          backgroundColor: FnvColors.appBarFond,
        ),
        body: Padding(
          padding: const EdgeInsets.all(paddingVerticalPage),
          child: Center(child: Text(details.exceptionAsString())),
        ),
      ),
    );
  };
}

void _captureException(final Object error, final StackTrace? stack) {
  debugPrint('Error: $error${stack == null ? '' : '\n$stack'}');
  unawaited(CrashReporting.captureException(error, stackTrace: stack));
}
