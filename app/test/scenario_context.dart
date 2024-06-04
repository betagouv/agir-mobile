import 'package:app/src/fonctionnalites/aides/domain/aide.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo_informations.dart';
import 'package:app/src/fonctionnalites/aides/domain/aide_velo_par_type.dart';
import 'package:app/src/fonctionnalites/authentification/domain/authentification_statut.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';

import 'aide_velo_repository_mock.dart';

class ScenarioContext {
  factory ScenarioContext() => _instance ??= ScenarioContext._();
  ScenarioContext._();
  AuthentificationStatut authentificationStatut =
      AuthentificationStatut.pasConnecte;
  String prenom = 'Lucas';
  String nom = 'Saudon';
  String adresseElectronique = 'lucas@saudon.fr';
  List<Fonctionnalites> fonctionnalitesDebloquees = <Fonctionnalites>[];
  AideVeloParType aideVeloParType = const AideVeloParType(
    mecaniqueSimple: [],
    electrique: [],
    cargo: [],
    cargoElectrique: [],
    pliant: [],
    motorisation: [],
  );
  AideVeloInformations aideVeloInformations = const AideVeloInformations(
    codePostal: '',
    ville: '',
    nombreDePartsFiscales: 0,
    revenuFiscal: 0,
  );
  List<Aide> aides = <Aide>[];
  List<String> communes = <String>[];
  AideVeloRepositoryMock? aideVeloRepositoryMock;
  static ScenarioContext? _instance;

  void dispose() => _instance = null;
}
