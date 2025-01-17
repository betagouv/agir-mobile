import 'package:app/features/notifications/domain/notification_data.dart';
import 'package:app/features/notifications/infrastructure/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServiceFake implements NotificationService {
  const NotificationServiceFake(this._authorizationStatus);

  final AuthorizationStatus _authorizationStatus;

  @override
  Future<String?> getToken() async => 'token';

  @override
  Future<void> initializeApp() async {}

  @override
  Future<AuthorizationStatus> requestPermission() async => _authorizationStatus;

  @override
  Stream<NotificationData> get onMessageOpenedApp => const Stream.empty();

  @override
  Future<void> deleteToken() async {}
}
