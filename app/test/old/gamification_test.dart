import 'package:app/features/gamification/domain/gamification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'set_up_widgets.dart';
import 'steps/iel_est_connecte.dart';
import 'steps/iel_lance_lapplication.dart';
import 'steps/le_serveur_retourne_cette_gamification.dart';

void main() {
  testWidgets(
    "On voit les points au démarrage de l'application",
    (final tester) async {
      setUpWidgets(tester);
      leServeurRetourneCetteGamification(const Gamification(points: 650));
      ielEstConnecte();
      await ielLanceLapplication(tester);
      expect(find.byKey(const ValueKey('650points')), findsOneWidget);
    },
  );
}
