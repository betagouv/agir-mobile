import 'package:app/features/quiz/domain/quiz.dart';

import '../scenario_context.dart';

/// Iel a le quiz suivant.
void ielALeQuizSuivant(final Quiz valeur) {
  ScenarioContext().quiz = valeur;
}
