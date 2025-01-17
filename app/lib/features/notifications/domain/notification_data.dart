import 'package:app/features/notifications/domain/notification_page_type.dart';
import 'package:equatable/equatable.dart';

class NotificationData extends Equatable {
  const NotificationData({required this.pageType, required this.pageId});

  final NotificationPageType pageType;

  final String pageId;

  @override
  List<Object?> get props => [pageType, pageId];
}
