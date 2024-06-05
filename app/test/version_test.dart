import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';

void main() {
  testWidgets(
    "Iel lance l'application et voit le numéro de version",
    (final tester) async {
      setUpWidgets(tester);
      await ielLanceLapplication(tester);
      ielVoitLeTexteDansTexteRiche('1.2.3+4');
    },
  );

  testWidgets(
    'Iel est sur le menu et voit le numéro de version',
    (final tester) async {
      setUpWidgets(tester);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSurAccessibilite(tester, Localisation.menu);
      ielVoitLeTexteDansTexteRiche('1.2.3+4');
    },
  );
}
