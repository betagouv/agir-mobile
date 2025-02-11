import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

final class ActionSummary extends Equatable {
  const ActionSummary({
    required this.themeType,
    required this.type,
    required this.id,
    required this.title,
    required this.subTitle,
    required this.numberOfActionsCompleted,
    required this.numberOfAidsAvailable,
  });

  final ThemeType themeType;
  final ActionType type;
  final String id;
  final String title;
  final String subTitle;
  final int numberOfActionsCompleted;
  final int numberOfAidsAvailable;

  @override
  List<Object?> get props => [
        themeType,
        type,
        id,
        title,
        subTitle,
        numberOfActionsCompleted,
        numberOfAidsAvailable,
      ];
}

enum ActionType {
  classique,
}
