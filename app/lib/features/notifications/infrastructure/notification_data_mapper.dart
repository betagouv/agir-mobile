import 'package:app/features/notifications/domain/notification_data.dart';
import 'package:app/features/notifications/domain/notification_page_type.dart';

abstract final class NotificationDataMapper {
  const NotificationDataMapper._();

  static NotificationData fromJson(final Map<String, dynamic> json) =>
      NotificationData(
        pageType: _actionStatusfromJson(json['page_type'] as String),
        pageId: json['page_id'] as String,
      );

  static NotificationPageType _actionStatusfromJson(final String json) =>
      switch (json) {
        'quiz' => NotificationPageType.quiz,
        'article' => NotificationPageType.article,
        'mission' => NotificationPageType.mission,
        _ => throw UnimplementedError(),
      };
}
