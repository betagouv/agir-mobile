import 'package:app/core/authentication/domain/authentication_status.dart';
import 'package:app/features/quiz/domain/quiz.dart';

import '../helpers/dio_mock.dart';
import 'mocks/quiz_port_mock.dart';

class ScenarioContext {
  factory ScenarioContext() => _instance ??= ScenarioContext._();
  ScenarioContext._();
  DioMock? dioMock;
  AuthenticationStatus authentificationStatut = const Unauthenticated();
  Quiz quiz = const Quiz(
    id: '',
    thematique: '',
    question: '',
    reponses: [],
    points: 0,
    explicationOk: '',
    explicationKo: '',
    article: null,
  );

  QuizPortMock? quizPortMock;
  static ScenarioContext? _instance;

  static void dispose() => _instance = null;
}
