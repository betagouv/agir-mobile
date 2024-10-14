import 'dart:convert';

import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/profil/core/domain/profil_port.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/profil/core/infrastructure/logement_mapper.dart';
import 'package:app/features/profil/informations/domain/entities/informations.dart';
import 'package:app/features/profil/logement/domain/logement.dart';
import 'package:fpdart/fpdart.dart';

class ProfilApiAdapter implements ProfilPort {
  const ProfilApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, Informations>> recupererProfil() async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response =
        await _apiClient.get(Uri.parse('/utilisateurs/$utilisateurId/profile'));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du profil'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(
      Informations(
        email: json['email'] as String,
        prenom: json['prenom'] as String?,
        nom: json['nom'] as String?,
        anneeDeNaissance: json['annee_naissance'] as int?,
        codePostal: json['code_postal'] as String?,
        commune: json['commune'] as String?,
        nombreDePartsFiscales:
            (json['nombre_de_parts_fiscales'] as num).toDouble(),
        revenuFiscal: (json['revenu_fiscal'] as num?)?.toInt(),
      ),
    );
  }

  @override
  Future<Either<Exception, void>> mettreAJour({
    required final String? prenom,
    required final String? nom,
    required final int? anneeDeNaissance,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  }) async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/profile');
    final body = jsonEncode({
      'annee_naissance': anneeDeNaissance,
      'nom': nom,
      'nombre_de_parts_fiscales': nombreDePartsFiscales,
      'prenom': prenom,
      'revenu_fiscal': revenuFiscal,
    });

    final response = await _apiClient.patch(uri, body: body);

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du profil'));
  }

  @override
  Future<Either<Exception, Logement>> recupererLogement() async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient
        .get(Uri.parse('/utilisateurs/$utilisateurId/logement'));

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la récupération du logement'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(LogementMapper.mapLogementFromJson(json));
  }

  @override
  Future<Either<Exception, void>> mettreAJourLogement({
    required final Logement logement,
  }) async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/logement');
    final body = jsonEncode(LogementMapper.mapLogementToJson(logement));

    final response = await _apiClient.patch(uri, body: body);

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du logement'));
  }

  @override
  Future<Either<Exception, void>> supprimerLeCompte() async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId');

    final response = await _apiClient.delete(uri);

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la suppression du compte'));
  }

  @override
  Future<Either<Exception, void>> changerMotDePasse({
    required final String motDePasse,
  }) async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/profile');
    final body = jsonEncode({'mot_de_passe': motDePasse});

    final response = await _apiClient.patch(uri, body: body);

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du mot de passe'));
  }

  @override
  Future<Either<Exception, void>> mettreAJourCodePostalEtCommune({
    required final String codePostal,
    required final String commune,
  }) async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/logement');
    final body = jsonEncode({'code_postal': codePostal, 'commune': commune});

    final response = await _apiClient.patch(uri, body: body);

    return isResponseSuccessful(response.statusCode)
        ? const Right(null)
        : Left(
            Exception(
              'Erreur lors de la mise à jour du code postal et de la commune',
            ),
          );
  }
}
