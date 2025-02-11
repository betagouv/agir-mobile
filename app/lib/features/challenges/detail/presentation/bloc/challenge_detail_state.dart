import 'package:app/features/challenges/core/domain/challenge_status.dart';
import 'package:app/features/challenges/detail/domain/challenge.dart';
import 'package:app/l10n/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

@immutable
sealed class ChallengeDetailState extends Equatable {
  const ChallengeDetailState();

  @override
  List<Object?> get props => [];
}

@immutable
final class ChallengeDetailInitial extends ChallengeDetailState {
  const ChallengeDetailInitial();
}

@immutable
final class ChallengeDetailLoadInProgress extends ChallengeDetailState {
  const ChallengeDetailLoadInProgress();
}

@immutable
final class ChallengeDetailLoadSuccess extends ChallengeDetailState {
  const ChallengeDetailLoadSuccess({
    required this.challenge,
    this.newStatus,
    this.newReason = const None(),
  });

  final Challenge challenge;
  final ChallengeStatus? newStatus;
  final Option<String?> newReason;

  String get acceptanceText => _getRadioButtonText(
        initialStatus: Localisation.jeReleveLAction,
        progressStatus: Localisation.actionRealisee,
      );

  String get refusalText => _getRadioButtonText(
        initialStatus: Localisation.pasPourMoi,
        progressStatus: Localisation.finalementPasPourMoi,
      );

  String _getRadioButtonText({
    required final String initialStatus,
    required final String progressStatus,
  }) =>
      switch (challenge.status) {
        ChallengeStatus.toDo || ChallengeStatus.refused => initialStatus,
        ChallengeStatus.inProgress ||
        ChallengeStatus.alreadyDone ||
        ChallengeStatus.abandonned ||
        ChallengeStatus.done =>
          progressStatus,
      };

  bool? get isAccepted => switch (newStatus ?? challenge.status) {
        ChallengeStatus.toDo || ChallengeStatus.inProgress => null,
        ChallengeStatus.abandonned || ChallengeStatus.refused => false,
        ChallengeStatus.alreadyDone || ChallengeStatus.done => true,
      };

  ChallengeDetailLoadSuccess copyWith({
    final Challenge? challenge,
    final ChallengeStatus? newStatus,
    final Option<String?>? newReason,
  }) =>
      ChallengeDetailLoadSuccess(
        challenge: challenge ?? this.challenge,
        newStatus: newStatus ?? this.newStatus,
        newReason: newReason ?? this.newReason,
      );

  @override
  List<Object?> get props => [challenge, newStatus, newReason];
}

@immutable
final class ChallengeDetailLoadFailure extends ChallengeDetailState {
  const ChallengeDetailLoadFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

@immutable
final class ChallengeDetailUpdateSuccess extends ChallengeDetailState {
  const ChallengeDetailUpdateSuccess();
}

@immutable
final class ChallengeDetailUpdateIgnored extends ChallengeDetailState {
  const ChallengeDetailUpdateIgnored();
}
