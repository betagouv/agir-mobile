import 'package:flutter/material.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

class TrackerNavigatorObserver extends RouteObserver<PageRoute<dynamic>> {
  void _trackPageView(final Route<dynamic>? route) {
    if (!MatomoTracker.instance.initialized) {
      return;
    }
    MatomoTracker.instance.trackPageViewWithName(
      actionName: route?.settings.name ?? 'inconnu',
    );
  }

  @override
  void didPush(
    final Route<dynamic> route,
    final Route<dynamic>? previousRoute,
  ) {
    super.didPush(route, previousRoute);
    _trackPageView(route);
  }

  @override
  void didPop(final Route<dynamic> route, final Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _trackPageView(previousRoute);
  }
}
