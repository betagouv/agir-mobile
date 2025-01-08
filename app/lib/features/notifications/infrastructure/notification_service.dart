// ignore_for_file: avoid-unassigned-stream-subscriptions

import 'package:app/features/notifications/infrastructure/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  const NotificationService();

  Future<void> initializeApp() async => Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

  Future<String?> getToken() async => FirebaseMessaging.instance.getToken();

  Future<AuthorizationStatus> requestPermission() async {
    final permission = await FirebaseMessaging.instance.requestPermission();

    return permission.authorizationStatus;
  }

  Future<void> deleteToken() async => FirebaseMessaging.instance.deleteToken();
}
