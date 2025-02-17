import 'package:app/features/mission/challenges/domain/mission_challenges.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
final class MissionChallengesState extends Equatable {
  const MissionChallengesState({required this.challenges});

  final MissionChallenges challenges;

  @override
  List<Object> get props => [challenges];
}
