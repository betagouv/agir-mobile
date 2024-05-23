import 'package:agir/src/pages/pre_onboarding/pre_onboarding_carrousel_page.dart';
import 'package:agir/src/pages/pre_onboarding/pre_onboarding_page.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter() => GoRouter(
      initialLocation: PreOnboardingPage.path,
      routes: [
        PreOnboardingPage.route(),
        PreOnboardingCarrouselPage.route(),
      ],
    );
