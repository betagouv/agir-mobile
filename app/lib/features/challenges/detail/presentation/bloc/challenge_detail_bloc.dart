import 'package:app/features/challenges/core/domain/challenge_status.dart';
import 'package:app/features/challenges/detail/infrastructure/challenge_repository.dart';
import 'package:app/features/challenges/detail/presentation/bloc/challenge_detail_event.dart';
import 'package:app/features/challenges/detail/presentation/bloc/challenge_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class ChallengeDetailBloc
    extends Bloc<ChallengeDetailEvent, ChallengeDetailState> {
  ChallengeDetailBloc({required final ChallengeRepository repository})
    : super(const ChallengeDetailInitial()) {
    on<ChallengeDetailLoadRequested>((final event, final emit) async {
      emit(const ChallengeDetailLoadInProgress());
      final result = await repository.fetchChallenge(event.id);
      result.fold(
        (final l) => emit(ChallengeDetailLoadFailure(l.toString())),
        (final r) => emit(ChallengeDetailLoadSuccess(challenge: r)),
      );
    });
    on<ChallengeDetailResponseSubmitted>((final event, final emit) async {
      if (state is! ChallengeDetailLoadSuccess) {
        emit(const ChallengeDetailLoadFailure('Oups, une erreur est survenue'));
      }

      final currentState = state as ChallengeDetailLoadSuccess;
      final status = currentState.challenge.status;
      final firstStep =
          status == ChallengeStatus.toDo || status == ChallengeStatus.refused;

      final newStatus =
          event.value
              ? firstStep
                  ? ChallengeStatus.inProgress
                  : ChallengeStatus.done
              : firstStep
              ? ChallengeStatus.refused
              : ChallengeStatus.abandonned;

      emit(currentState.copyWith(newStatus: newStatus));
    });

    on<ChallengeDetailReasonChanged>((final event, final emit) async {
      final currentState = state as ChallengeDetailLoadSuccess;
      emit(currentState.copyWith(newReason: Some(event.reason)));
    });

    on<ChallengeDetailValidatePressed>((final event, final emit) async {
      if (state is! ChallengeDetailLoadSuccess) {
        emit(const ChallengeDetailLoadFailure('Oups, une erreur est survenue'));

        return;
      }
      final currentState = state as ChallengeDetailLoadSuccess;
      if (currentState.newStatus == null && currentState.newReason.isNone()) {
        emit(const ChallengeDetailUpdateIgnored());

        return;
      }

      final newStatus = currentState.newStatus ?? currentState.challenge.status;
      final result = await repository.updateChallengeStatus(
        id: currentState.challenge.id,
        status: newStatus,
        reason:
            newStatus == ChallengeStatus.refused
                ? (currentState.newReason.fold(() => null, (final r) => r) ??
                    currentState.challenge.reason)
                : null,
      );

      result.fold(
        (final l) => emit(ChallengeDetailLoadFailure(l.toString())),
        (final r) => emit(const ChallengeDetailUpdateSuccess()),
      );
    });
  }
}
