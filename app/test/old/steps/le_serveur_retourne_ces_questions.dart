import 'package:app/features/know_your_customer/core/domain/question.dart';

import '../scenario_context.dart';

/// Le serveur retourne ces questions.
void leServeurRetourneCesQuestions(final List<Question> questions) {
  ScenarioContext().questions = questions;
}
