import 'package:app/core/infrastructure/endpoints.dart';

import '../scenario_context.dart';

/// Le serveur retourne ces questions.
void leServeurRetourneCesQuestions(final List<Map<String, dynamic>> questions) {
  ScenarioContext().dioMock!.getM(
        Endpoints.questionsKyc,
        responseData: questions,
      );
  questions.forEach(leServeurRetourneCetteQuestion);
}

void leServeurRetourneCetteQuestion(final Map<String, dynamic> question) {
  final id = question['code'] as String;
  ScenarioContext().dioMock!.getM(
        Endpoints.questionKyc(id),
        responseData: question,
      );
  ScenarioContext().dioMock!.putM(Endpoints.questionKyc(id));
}
