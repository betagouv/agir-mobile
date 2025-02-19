import 'package:app/features/actions/domain/action_type.dart';
import 'package:equatable/equatable.dart';

final class ActionSummary extends Equatable {
  const ActionSummary({
    required this.type,
    required this.id,
    required this.title,
    required this.numberOfActionsCompleted,
    required this.numberOfAidsAvailable,
  });

  final ActionType type;
  final String id;
  final String title;
  final int numberOfActionsCompleted;
  final int numberOfAidsAvailable;

  @override
  List<Object?> get props => [type, id, title, numberOfActionsCompleted, numberOfAidsAvailable];
}
