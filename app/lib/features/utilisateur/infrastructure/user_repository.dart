import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/features/utilisateur/domain/user.dart';
import 'package:fpdart/fpdart.dart';

class UserRepository {
  const UserRepository({required final DioHttpClient client})
    : _client = client;

  final DioHttpClient _client;

  Future<Either<Exception, User>> fetch() async {
    final response = await _client.get(Endpoints.utilisateur);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception("Erreur lors de la récupération de l'utilisateur"));
    }

    final json = response.data as Map<String, dynamic>;

    return Right(
      User(
        firstName: json['prenom'] as String? ?? '',
        isIntegrationCompleted: json['is_onboarding_done'] as bool,
      ),
    );
  }
}
