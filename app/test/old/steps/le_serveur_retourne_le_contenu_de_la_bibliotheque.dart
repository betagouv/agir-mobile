import 'package:app/features/bibliotheque/domain/bibliotheque.dart';

import '../scenario_context.dart';

/// Le serveur retourne le contenu de la bibliothèque.
void leServeurRetourneLeContenuDeLaBibliotheque(
  final Bibliotheque bibliotheque,
) {
  ScenarioContext().bibliotheque = bibliotheque;
}
