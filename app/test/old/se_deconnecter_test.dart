import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  testWidgets(
    'Iel appuie sur se déconnecter et voit la premiere page de onboarding',
    (final tester) async {
      setUpWidgets(tester);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSurAccessibilite(tester, Localisation.menu);
      await ielAppuieSur(tester, Localisation.seDeconnecter);
      ielVoitLeTexte(Localisation.preOnboardingTitre);
    },
  );
}
