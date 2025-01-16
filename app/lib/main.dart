import 'dart:async';

import 'package:app/app/app_setup.dart';
import 'package:app/core/error/infrastructure/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  final widgetsBinding = SentryWidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await ErrorHandler.register();

  runApp(const AppSetup());
}
