import 'dart:async';

import 'package:app/features/authentification/core/domain/authentification_statut.dart';
import 'package:flutter/material.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(final Stream<AuthentificationStatut> stream) {
    notifyListeners();
    _subscription = stream.listen((final _) => notifyListeners());
  }

  late final StreamSubscription<AuthentificationStatut> _subscription;

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
