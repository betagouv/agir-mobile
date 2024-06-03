import 'package:app/src/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/steps.dart';

void main() {
  testWidgets("Iel lance l'application et voit le numéro de version",
      (final tester) async {
    setUpWidgets(tester);
    await ielLanceLapplication(tester);
    await ielVoitLeTexteDansTexteRiche(tester, '1.2.3+4');
  });

  testWidgets('Iel est sur le menu et voit le numéro de version',
      (final tester) async {
    setUpWidgets(tester);
    await ielEstConnecte(tester);
    await ielLanceLapplication(tester);
    await ielAppuieSurAccessibilite(tester, Localisation.menu);
    await ielVoitLeTexteDansTexteRiche(tester, '1.2.3+4');
  });
}
