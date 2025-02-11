import 'package:app/features/challenges/list/domain/challenge_item.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ChallengesState extends Equatable {
  const ChallengesState();

  @override
  List<Object?> get props => [];
}

@immutable
final class ChallengesInitial extends ChallengesState {
  const ChallengesInitial();
}

@immutable
final class ChallengesLoadSuccess extends ChallengesState {
  const ChallengesLoadSuccess({
    required this.themeType,
    required this.challenges,
  });

  final ThemeType? themeType;
  final List<ChallengeItem> challenges;

  @override
  List<Object?> get props => [challenges, themeType];
}
