import 'dart:convert';

import 'package:app/core/error/infrastructure/api_erreur_helpers.dart';
import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/questions/first_name/domain/first_name.dart';
import 'package:app/features/questions/first_name/domain/first_name_port.dart';
import 'package:fpdart/fpdart.dart';

final class FirstNameAdapter implements FirstNamePort {
  const FirstNameAdapter({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  @override
  Future<Either<Exception, Unit>> addFirstName(
    final FirstName firstName,
  ) async {
    final response = await _client.patch(
      Endpoints.profile,
      data: jsonEncode({'prenom': firstName.value}),
    );

    return isResponseSuccessful(response.statusCode)
        ? const Right(unit)
        : handleError(
            jsonEncode(response.data),
            defaultMessage: 'Erreur lors de la mise à jour du prénom',
          );
  }
}
