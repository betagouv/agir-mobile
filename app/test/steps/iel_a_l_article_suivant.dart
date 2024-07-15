import 'package:app/features/articles/domain/article.dart';

import '../scenario_context.dart';

/// Iel a l'article suivant.
void ielALArticleSuivant(final Article valeur) {
  ScenarioContext().article = valeur;
}
