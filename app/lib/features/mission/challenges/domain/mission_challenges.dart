import 'package:app/features/mission/challenges/domain/mission_challenge.dart';
import 'package:equatable/equatable.dart';

final class MissionChallenges extends Equatable {
  const MissionChallenges({
    required this.values,
    required this.canBeCompleted,
    required this.isCompleted,
  });

  final List<MissionChallenge> values;
  final bool canBeCompleted;
  final bool isCompleted;

  @override
  List<Object> get props => [values, canBeCompleted, isCompleted];
}
