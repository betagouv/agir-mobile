import 'package:flutter/widgets.dart';
import 'package:matomo_tracker/matomo_tracker.dart';

class Tracker {
  const Tracker();

  Future<void> init({
    required final String siteId,
    required final String url,
  }) async {
    await MatomoTracker.instance
        .initialize(siteId: siteId, url: url, verbosityLevel: Level.all);
  }

  void trackClick(final String page, final String contenu) {
    if (!MatomoTracker.instance.initialized) {
      return;
    }
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(category: 'click', action: page, name: contenu),
    );
  }

  void trackNotificationOpened(final String name) {
    if (!MatomoTracker.instance.initialized) {
      return;
    }
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(
        category: 'notification',
        action: 'opened',
        name: name,
      ),
    );
  }

  void dispose() {
    MatomoTracker.instance.dispose();
  }

  NavigatorObserver get navigatorObserver => MatomoGlobalObserver();
}
