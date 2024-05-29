import 'package:app/src/l10n/l10n.dart';
import 'package:app/src/pages/accueil/accueil_page.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/steps.dart';

void main() {
  testWidgets("Iel arrive sur la page d'accueil alors il voit son prénom",
      (final tester) async {
    setUpWidgets(tester);
    const prenom = 'Pierre-Emmanuel';
    await ielSappelle(tester, prenom);
    await ielEstConnecte(tester);
    await ielLanceLapplication(tester);
    expect(find.byType(AccueilPage), findsOneWidget);
    await ielVoitLeTexteDansTexteRiche(
      tester,
      Localisation.prenomExclamation(prenom),
    );
  });

  testWidgets("Iel arrive sur la page d'accueil alors il voit son prénom 2",
      (final tester) async {
    setUpWidgets(tester);
    const prenom = 'Lucas';
    await ielSappelle(tester, prenom);
    await ielEstConnecte(tester);
    await ielLanceLapplication(tester);
    expect(find.byType(AccueilPage), findsOneWidget);
    await ielVoitLeTexteDansTexteRiche(
      tester,
      Localisation.prenomExclamation(prenom),
    );
  });
}
