// ignore_for_file: avoid-unassigned-stream-subscriptions

import 'dart:async';

import 'package:app/features/notifications/infrastructure/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final _messageController = StreamController<RemoteMessage>.broadcast();

  Future<void> initializeApp() async => Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

  Future<String?> getToken() async => FirebaseMessaging.instance.getToken();

  Future<AuthorizationStatus> requestPermission() async {
    final permission = await FirebaseMessaging.instance.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.authorized) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _messageController.add(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_messageController.add);

    return permission.authorizationStatus;
  }

  Stream<RemoteMessage> get onMessageOpenedApp => _messageController.stream;

  Future<void> deleteToken() async => FirebaseMessaging.instance.deleteToken();
}
