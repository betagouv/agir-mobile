import 'package:agir/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'device_info.dart';
import 'steps/steps.dart';

void main() {
  testWidgets("Iel lance l'application pour la première fois",
      (final tester) async {
    DeviceInfo.setup(tester);

    await ielLanceLapplication(tester);
    await ielVoitLeTexte(tester, Localisation.preOnboardingTitre);
    await ielAppuieSurCommencer(tester);
    await ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding1);
    await ielGlisseDeLaDroiteVersLaGauche(tester);
    await ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding2);
    await ielGlisseDeLaDroiteVersLaGauche(tester);
    await ielVoitLeTexteMarkdown(tester, Localisation.preOnboarding3);
    await ielGlisseDeLaDroiteVersLaGauche(tester);
    await ielVoitLeTexte(tester, Localisation.preOnboardingFinTitre);
  });
}
