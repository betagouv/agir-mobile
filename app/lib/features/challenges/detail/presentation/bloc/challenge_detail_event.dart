import 'package:app/features/challenges/core/domain/challenge_id.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ChallengeDetailEvent extends Equatable {
  const ChallengeDetailEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ChallengeDetailLoadRequested extends ChallengeDetailEvent {
  const ChallengeDetailLoadRequested(this.id);

  final ChallengeId id;

  @override
  List<Object> get props => [id];
}

@immutable
final class ChallengeDetailResponseSubmitted extends ChallengeDetailEvent {
  const ChallengeDetailResponseSubmitted(this.value);

  final bool value;

  @override
  List<Object> get props => [value];
}

@immutable
final class ChallengeDetailReasonChanged extends ChallengeDetailEvent {
  const ChallengeDetailReasonChanged(this.reason);

  final String reason;

  @override
  List<Object> get props => [reason];
}

@immutable
final class ChallengeDetailValidatePressed extends ChallengeDetailEvent {
  const ChallengeDetailValidatePressed();
}
