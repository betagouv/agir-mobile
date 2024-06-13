import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_appuie_sur_accesibilite.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_sappelle.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  testWidgets(
    'Iel va sur la page profil',
    (final tester) async {
      setUpWidgets(tester);
      const prenom = 'Michel';
      const nom = 'Dupont';
      ielSappelle(prenom, nom: nom);
      ielEstConnecte();
      await ielLanceLapplication(tester);
      await ielAppuieSurAccessibilite(tester, Localisation.menu);
      await ielAppuieSur(tester, Localisation.monProfil);
      ielVoitLeTexte(Localisation.identitePersonnelle);
      ielVoitLeTexte(prenom);
      ielVoitLeTexte(nom);
    },
    skip: true,
  );
}
