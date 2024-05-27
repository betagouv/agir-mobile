import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';

class ScenarioContext {
  factory ScenarioContext() => _instance ??= ScenarioContext._();
  ScenarioContext._();
  static ScenarioContext? _instance;

  void dispose() => _instance = null;

  AuthentificationStatut authentificationStatut =
      AuthentificationStatut.pasConnecte;
}
