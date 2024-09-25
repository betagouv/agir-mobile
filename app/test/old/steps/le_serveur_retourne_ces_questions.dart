import 'package:app/features/mieux_vous_connaitre/core/domain/question.dart';

import '../scenario_context.dart';

/// Le serveur retourne ces questions.
void leServeurRetourneCesQuestions(final List<Question> questions) {
  ScenarioContext().questions = questions;
}
