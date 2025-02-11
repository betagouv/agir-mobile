import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ChallengesEvent extends Equatable {
  const ChallengesEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class ChallengesLoadRequested extends ChallengesEvent {
  const ChallengesLoadRequested(this.themeType);

  final ThemeType? themeType;

  @override
  List<Object?> get props => [themeType];
}

@immutable
final class ChallengesRefreshRequested extends ChallengesEvent {
  const ChallengesRefreshRequested();

  @override
  List<Object?> get props => [];
}
