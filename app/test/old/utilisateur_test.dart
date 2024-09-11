import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_sappelle.dart';
import 'steps/iel_voit_le_texte_dans_texte_riche.dart';

void main() {
  testWidgets(
    "Iel arrive sur la page d'accueil alors il voit son prénom",
    (final tester) async {
      setUpWidgets(tester);
      const prenom = 'Pierre-Emmanuel';
      ielSappelle(prenom);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      ielVoitLeTexteDansTexteRiche(Localisation.prenomExclamation(prenom));
    },
  );

  testWidgets(
    "Iel arrive sur la page d'accueil alors il voit son prénom 2",
    (final tester) async {
      setUpWidgets(tester);
      const prenom = 'Lucas';
      ielSappelle(prenom);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      ielVoitLeTexteDansTexteRiche(Localisation.prenomExclamation(prenom));
    },
  );
}
