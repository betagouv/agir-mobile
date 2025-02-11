import 'package:app/core/infrastructure/dio_http_client.dart';
import 'package:app/core/infrastructure/endpoints.dart';
import 'package:app/core/infrastructure/http_client_helpers.dart';
import 'package:app/core/notifications/infrastructure/notification_service.dart';
import 'package:fpdart/fpdart.dart';

class NotificationRepository {
  const NotificationRepository({required final DioHttpClient client, required final NotificationService notificationService})
    : _client = client,
      _notificationService = notificationService;

  final DioHttpClient _client;
  final NotificationService _notificationService;

  Future<Either<Exception, void>> saveToken() async {
    final token = await _notificationService.getToken();
    final response = await _client.put(Endpoints.notificationToken, data: {'token': token});

    return isResponseUnsuccessful(response.statusCode)
        ? Left(Exception('Erreur lors de la sauvegarde du token de notification'))
        : const Right(null);
  }

  Future<Either<Exception, void>> deleteNotificationToken() async {
    final response = await _client.delete(Endpoints.notificationToken);

    if (isResponseUnsuccessful(response.statusCode)) {
      return Left(Exception('Erreur lors de la suppression du token de notification'));
    }

    await _notificationService.deleteToken();

    return const Right(null);
  }
}
