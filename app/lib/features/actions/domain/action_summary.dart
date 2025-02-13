import 'package:equatable/equatable.dart';

final class ActionSummary extends Equatable {
  const ActionSummary({
    required this.id,
    required this.title,
    required this.numberOfActionsCompleted,
    required this.numberOfAidsAvailable,
  });

  final String id;
  final String title;
  final int numberOfActionsCompleted;
  final int numberOfAidsAvailable;

  @override
  List<Object?> get props => [
    id,
    title,
    numberOfActionsCompleted,
    numberOfAidsAvailable,
  ];
}
