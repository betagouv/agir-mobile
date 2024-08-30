import 'package:app/l10n/l10n.dart';
import 'package:flutter_test/flutter_test.dart';

import 'scenario_context.dart';
import 'set_up_widgets.dart';
import 'steps/iel_appuie_sur.dart';
import 'steps/iel_ecrit_dans_le_champ.dart';
import 'steps/iel_ecrit_le_code.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/iel_voit_le_texte.dart';

void main() {
  testWidgets('Iel a oublié son mot de passe', (final tester) async {
    setUpWidgets(tester);
    await ielLanceLapplication(tester);
    await ielAppuieSur(tester, Localisation.jaiDejaUnCompte);
    await ielAppuieSur(tester, Localisation.motDePasseOublie);
    ielVoitLeTexte(Localisation.motDePasseOublieTitre);

    const email = 'joe@doe.com';
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.adresseEmail,
      enterText: email,
    );
    await ielAppuieSur(tester, Localisation.valider);
    final authentificationPort = ScenarioContext().authentificationPortMock!;
    expect(authentificationPort.oublieMotDePasseAppele, isTrue);
    ielVoitLeTexte(Localisation.motDePasseOublieTitre2);
    ielVoitLeTexte(
      Localisation.entrezLeCodeRecuOublieMotDePasseParMailDetails(email),
    );
    await ielEcritLeCode(tester, enterText: '123456');
    await ielEcritDansLeChamp(
      tester,
      label: Localisation.motDePasse,
      enterText: 'Azertyuiop1&',
    );
    await ielAppuieSur(tester, Localisation.valider);
    expect(authentificationPort.modifierMotDePasseAppele, isTrue);
    ielVoitLeTexte(Localisation.meConnecter);
  });
}
