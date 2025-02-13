// ignore_for_file: avoid-long-parameter-list

import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/features/profil/core/infrastructure/logement_mapper.dart';
import 'package:app/features/profil/logement/domain/logement.dart';

import 'scenario_context.dart';

/// Iel a ces informations de profile.
void ielACesInformationsDeProfil({
  final String email = '',
  final String prenom = '',
  final String nom = '',
  final String codePostal = '',
  final String commune = '',
  final double nombreDePartsFiscales = 0,
  final int? revenuFiscal,
}) {
  ScenarioContext().dioMock!.getM(
    Endpoints.profile,
    responseData: {
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'code_postal': codePostal,
      'commune': commune,
      'revenu_fiscal': revenuFiscal,
      'nombre_de_parts_fiscales': nombreDePartsFiscales,
      'annee_naissance': null,
    },
  );
}

/// Iel a ces informations de logement.
void ielACesInformationsDeLogement(final Logement logement) {
  ScenarioContext().dioMock!.getM(
    Endpoints.logement,
    responseData: LogementMapper.mapLogementToJson(logement),
  );
}
