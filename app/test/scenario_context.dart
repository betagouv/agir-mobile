import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';

import 'aide_velo_repository_mock.dart';

class ScenarioContext {
  factory ScenarioContext() => _instance ??= ScenarioContext._();
  ScenarioContext._();
  static ScenarioContext? _instance;

  void dispose() => _instance = null;

  AuthentificationStatut authentificationStatut =
      AuthentificationStatut.pasConnecte;
  String prenom = 'Lucas';
  List<Fonctionnalites> fonctionnalitesDebloquees = <Fonctionnalites>[];
  List<Aide> aides = <Aide>[];
  List<String> communes = <String>[];
  AideVeloRepositoryMock aideVeloRepositoryMock = AideVeloRepositoryMock();
}
