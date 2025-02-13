import 'dart:convert';

import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/profil/core/infrastructure/logement_mapper.dart';
import 'package:app/features/profil/informations/domain/entities/informations.dart';
import 'package:app/features/profil/logement/domain/logement.dart';
import 'package:fpdart/fpdart.dart';

class ProfilRepository {
  const ProfilRepository({required final DioHttpClient client}) : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, Informations>> recupererProfil() async {
    final response = await _client.get(Endpoints.profile);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du profil'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(
      Informations(
        email: json['email'] as String,
        prenom: json['prenom'] as String?,
        nom: json['nom'] as String?,
        anneeDeNaissance: json['annee_naissance'] as int?,
        codePostal: json['code_postal'] as String?,
        commune: json['commune'] as String?,
        nombreDePartsFiscales: (json['nombre_de_parts_fiscales'] as num).toDouble(),
        revenuFiscal: (json['revenu_fiscal'] as num?)?.toInt(),
      ),
    );
  }

  Future<Either<Exception, void>> mettreAJour({
    required final String? prenom,
    required final String? nom,
    required final int? anneeDeNaissance,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  }) async {
    final response = await _client.patch(
      Endpoints.profile,
      data: jsonEncode({
        'annee_naissance': anneeDeNaissance,
        'nom': nom,
        'nombre_de_parts_fiscales': nombreDePartsFiscales,
        'prenom': prenom,
        'revenu_fiscal': revenuFiscal,
      }),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du profil'));
  }

  Future<Either<Exception, Logement>> recupererLogement() async {
    final response = await _client.get(Endpoints.logement);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du logement'));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(LogementMapper.mapLogementFromJson(json));
  }

  Future<Either<Exception, void>> mettreAJourLogement({required final Logement logement}) async {
    final response = await _client.patch(Endpoints.logement, data: jsonEncode(LogementMapper.mapLogementToJson(logement)));

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du logement'));
  }

  Future<Either<Exception, void>> supprimerLeCompte() async {
    final response = await _client.delete(Endpoints.utilisateur);

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la suppression du compte'));
  }

  Future<Either<Exception, void>> changerMotDePasse({required final String motDePasse}) async {
    final response = await _client.patch(Endpoints.profile, data: jsonEncode({'mot_de_passe': motDePasse}));

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du mot de passe'));
  }

  Future<Either<Exception, void>> mettreAJourCodePostalEtCommune({
    required final String codePostal,
    required final String commune,
  }) async {
    final response = await _client.patch(Endpoints.logement, data: jsonEncode({'code_postal': codePostal, 'commune': commune}));

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du code postal et de la commune'));
  }
}
