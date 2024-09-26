import 'dart:async';

import 'package:app/features/authentication/domain/authentication_service.dart';
import 'package:app/features/authentication/domain/authentication_status.dart';
import 'package:flutter/material.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(final AuthenticationService authenticationService) {
    notifyListeners();
    _subscription = authenticationService.authenticationStatus
        .listen((final _) => notifyListeners());
  }

  late final StreamSubscription<AuthenticationStatus> _subscription;

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
