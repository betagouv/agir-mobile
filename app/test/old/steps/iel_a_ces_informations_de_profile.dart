// ignore_for_file: avoid-long-parameter-list

import 'package:app/features/profil/logement/presentation/bloc/mon_logement_state.dart';

import '../scenario_context.dart';

/// Iel a ces informations de profile.
void ielACesInformationsDeProfil({
  final String codePostal = '',
  final String commune = '',
  final int nombreAdultes = 0,
  final int nombreEnfants = 0,
  final TypeDeLogement? typeDeLogement,
  final double nombreDePartsFiscales = 0,
  final int? revenuFiscal,
  final bool? estProprietaire,
  final Superficie? superficie,
  final Chauffage? chauffage,
  final bool? plusDe15Ans,
  final Dpe? dpe,
}) {
  ScenarioContext().codePostal = codePostal;
  ScenarioContext().commune = commune;
  ScenarioContext().nombreAdultes = nombreAdultes;
  ScenarioContext().nombreEnfants = nombreEnfants;
  ScenarioContext().nombreDePartsFiscales = nombreDePartsFiscales;
  ScenarioContext().revenuFiscal = revenuFiscal;
  ScenarioContext().typeDeLogement = typeDeLogement;
  ScenarioContext().estProprietaire = estProprietaire;
  ScenarioContext().superficie = superficie;
  ScenarioContext().chauffage = chauffage;
  ScenarioContext().plusDe15Ans = plusDe15Ans;
  ScenarioContext().dpe = dpe;
}
