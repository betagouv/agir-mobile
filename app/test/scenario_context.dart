import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_informations.dart';
import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_par_type.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';

import 'mocks/aide_velo_port_mock.dart';

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
  AideVeloPortMock? aideVeloRepositoryMock;
  static ScenarioContext? _instance;

  void dispose() => _instance = null;
}
