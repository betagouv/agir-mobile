import 'package:app/features/mission/challenges/domain/mission_challenges.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class MissionChallengesState extends Equatable {
  const MissionChallengesState({required this.challenges});

  final MissionChallenges challenges;

  @override
  List<Object> get props => [challenges];
}
