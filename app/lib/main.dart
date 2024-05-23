import 'dart:ui';

import 'package:agir/src/app.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  _registerErrorHandlers();

  runApp(const App());
}

void _registerErrorHandlers() {
  FlutterError.onError = (final details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };

  PlatformDispatcher.instance.onError = (final error, final stack) {
    debugPrint(error.toString());
    return true;
  };

  ErrorWidget.builder = (final details) => Scaffold(
        appBar: AppBar(
          backgroundColor: DsfrColors.redMarianneMain472,
          title: const Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      );
}
