import 'package:app/core/authentication/domain/authentication_status.dart';

import '../helpers/dio_mock.dart';

class ScenarioContext {
  factory ScenarioContext() => _instance ??= ScenarioContext._();
  ScenarioContext._();
  DioMock? dioMock;
  AuthenticationStatus authentificationStatut = const Unauthenticated();

  static ScenarioContext? _instance;

  static void dispose() => _instance = null;
}
