import 'dart:convert';

import 'package:app/core/error/infrastructure/api_erreur_helpers.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_api_client.dart';
import 'package:app/features/first_name/domain/first_name.dart';
import 'package:app/features/first_name/domain/first_name_port.dart';
import 'package:app/features/profil/core/domain/utilisateur_id_non_trouve_exception.dart';
import 'package:fpdart/fpdart.dart';

final class FirstNameAdapter implements FirstNamePort {
  const FirstNameAdapter({required final AuthentificationApiClient client})
      : _apiClient = client;

  final AuthentificationApiClient _apiClient;

  @override
  Future<Either<Exception, Unit>> addFirstName(
    final FirstName firstName,
  ) async {
    final utilisateurId = _apiClient.recupererUtilisateurId;
    if (utilisateurId == null) {
      return const Left(UtilisateurIdNonTrouveException());
    }

    final uri = Uri.parse('/utilisateurs/$utilisateurId/profile');
    final body = jsonEncode({'prenom': firstName.value});

    final response = await _apiClient.patch(uri, body: body);

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : handleError(
            response.body,
            defaultMessage: 'Erreur lors de la mise à jour du prénom',
          );
  }
}
