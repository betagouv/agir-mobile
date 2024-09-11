import 'dart:convert';
import 'dart:io';

import 'package:app/features/authentification/infrastructure/adapters/authentification_api_client.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:app/features/profil/informations/domain/entities/informations.dart';
import 'package:app/features/profil/infrastructure/adapters/logement_mapper.dart';
import 'package:app/features/profil/logement/domain/entities/logement.dart';
import 'package:fpdart/fpdart.dart';

class ProfilApiAdapter implements ProfilPort {
  const ProfilApiAdapter({
    required final AuthentificationApiClient apiClient,
  }) : _apiClient = apiClient;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, Informations>> recupererProfil() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response =
        await _apiClient.get(Uri.parse('/utilisateurs/$utilisateurId/profile'));

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération du profil'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(
      Informations(
        prenom: json['prenom'] as String?,
        nom: json['nom'] as String?,
        email: json['email'] as String,
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
    required final String email,
    required final double nombreDePartsFiscales,
    required final int? revenuFiscal,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/profile');
    final body = jsonEncode({
      'email': email,
      'nom': nom,
      'nombre_de_parts_fiscales': nombreDePartsFiscales,
      'prenom': prenom,
      'revenu_fiscal': revenuFiscal,
    });

    final response = await _apiClient.patch(uri, body: body);

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du profil'));
  }

  @override
  Future<Either<Exception, Logement>> recupererLogement() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final response = await _apiClient
        .get(Uri.parse('/utilisateurs/$utilisateurId/logement'));

    if (response.statusCode != HttpStatus.ok) {
      return Left(Exception('Erreur lors de la récupération du logement'));
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Right(LogementMapper.mapLogementFromJson(json));
  }

  @override
  Future<Either<Exception, void>> mettreAJourLogement({
    required final Logement logement,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/logement');
    final body = jsonEncode(LogementMapper.mapLogementToJson(logement));

    final response = await _apiClient.patch(uri, body: body);

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du logement'));
  }

  @override
  Future<Either<Exception, void>> supprimerLeCompte() async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId');

    final response = await _apiClient.delete(uri);

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors de la suppression du compte'));
  }

  @override
  Future<Either<Exception, void>> changerMotDePasse({
    required final String motDePasse,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/profile');
    final body = jsonEncode({'mot_de_passe': motDePasse});

    final response = await _apiClient.patch(uri, body: body);

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(Exception('Erreur lors de la mise à jour du mot de passe'));
  }

  @override
  Future<Either<Exception, void>> mettreAJourCodePostalEtCommune({
    required final String codePostal,
    required final String commune,
  }) async {
    final utilisateurId = await _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/logement');
    final body = jsonEncode({'code_postal': codePostal, 'commune': commune});

    final response = await _apiClient.patch(uri, body: body);

    return response.statusCode == HttpStatus.ok
        ? const Right(null)
        : Left(
            Exception(
              'Erreur lors de la mise à jour du code postal et de la commune',
            ),
          );
  }
}
