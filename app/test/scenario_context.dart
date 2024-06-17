import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_par_type.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/profil/mon_logement/presentation/blocs/mon_logement_state.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';

import 'mocks/aide_velo_port_mock.dart';
import 'mocks/profil_port_mock.dart';

class ScenarioContext {
  factory ScenarioContext() => _instance ??= ScenarioContext._();
  ScenarioContext._();
  AuthentificationStatut authentificationStatut =
      AuthentificationStatut.pasConnecte;
  String prenom = 'Lucas';
  String nom = 'Saudon';
  String email = 'lucas@saudon.fr';
  String codePostal = '75018';
  String commune = 'Paris';
  int nombreAdultes = 1;
  int nombreEnfants = 0;
  TypeDeLogement? typeDeLogement;
  bool? estProprietaire;
  Superficie? superficie;
  Chauffage? chauffage;
  bool? plusDe15Ans;
  Dpe? dpe;
  double nombreDePartsFiscales = 0;
  int? revenuFiscal;
  List<Fonctionnalites> fonctionnalitesDebloquees = <Fonctionnalites>[];
  AideVeloParType aideVeloParType = const AideVeloParType(
    mecaniqueSimple: [],
    electrique: [],
    cargo: [],
    cargoElectrique: [],
    pliant: [],
    motorisation: [],
  );
  List<Aide> aides = <Aide>[];
  List<String> communes = <String>[];
  AideVeloPortMock? aideVeloPortMock;
  ProfilPortMock? profilPortMock;
  static ScenarioContext? _instance;

  void dispose() => _instance = null;
}
