// ignore_for_file: avoid-unassigned-stream-subscriptions

import 'dart:async';

import 'package:app/core/notifications/domain/notification_data.dart';
import 'package:app/core/notifications/infrastructure/firebase_options.dart';
import 'package:app/core/notifications/infrastructure/notification_data_mapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  static const _topicAll = 'all';
  final _messageController = StreamController<NotificationData>.broadcast();

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
      await FirebaseMessaging.instance.subscribeToTopic(_topicAll);
    }

    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null && initialMessage.data.isNotEmpty) {
      _messageController
          .add(NotificationDataMapper.fromJson(initialMessage.data));
    }

    FirebaseMessaging.onMessageOpenedApp.listen((final event) {
      if (event.data.isEmpty) {
        return;
      }

      _messageController.add(NotificationDataMapper.fromJson(event.data));
    });

    return permission.authorizationStatus;
  }

  Stream<NotificationData> get onMessageOpenedApp => _messageController.stream;

  Future<void> deleteToken() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(_topicAll);
    await FirebaseMessaging.instance.deleteToken();
  }
}
