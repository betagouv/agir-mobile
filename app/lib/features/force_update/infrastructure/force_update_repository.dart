import 'package:app/features/authentification/core/infrastructure/dio_http_client.dart';
import 'package:fpdart/fpdart.dart';

final class ForceUpdateRepository {
  const ForceUpdateRepository({required final DioHttpClient client})
      : _client = client;

  final DioHttpClient _client;

  Either<Exception, Unit> checkVersion() => const Right(unit);
}
