import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:app/features/actions/detail/infrastructure/action_repository.dart';
import 'package:app/features/actions/detail/presentation/bloc/action_detail_event.dart';
import 'package:app/features/actions/detail/presentation/bloc/action_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

// Bloc
class ActionDetailBloc extends Bloc<ActionDetailEvent, ActionDetailState> {
  ActionDetailBloc({required final ActionRepository repository})
      : super(const ActionDetailInitial()) {
    on<ActionDetailLoadRequested>((final event, final emit) async {
      emit(const ActionDetailLoadInProgress());
      final action = await repository.fetchAction(event.id);
      action.fold(
        (final l) => emit(ActionDetailLoadFailure(l.toString())),
        (final r) => emit(ActionDetailLoadSuccess(action: r)),
      );
    });
    on<ActionDetailResponseSubmitted>((final event, final emit) async {
      if (state is! ActionDetailLoadSuccess) {
        emit(const ActionDetailLoadFailure('Oups, une erreur est survenue'));
      }

      final currentState = state as ActionDetailLoadSuccess;
      final status = currentState.action.status;
      final firstStep =
          status == ActionStatus.toDo || status == ActionStatus.refused;

      final newStatus = event.value
          ? firstStep
              ? ActionStatus.inProgress
              : ActionStatus.done
          : firstStep
              ? ActionStatus.refused
              : ActionStatus.abandonned;

      emit(currentState.copyWith(newStatus: newStatus));
    });

    on<ActionDetailReasonChanged>((final event, final emit) async {
      final currentState = state as ActionDetailLoadSuccess;
      emit(currentState.copyWith(newReason: Some(event.reason)));
    });

    on<ActionDetailValidatePressed>((final event, final emit) async {
      if (state is! ActionDetailLoadSuccess) {
        emit(const ActionDetailLoadFailure('Oups, une erreur est survenue'));

        return;
      }
      final currentState = state as ActionDetailLoadSuccess;
      if (currentState.newStatus == null && currentState.newReason.isNone()) {
        emit(const ActionDetailUpdateIgnored());

        return;
      }

      final newStatus = currentState.newStatus ?? currentState.action.status;
      final result = await repository.updateActionStatus(
        id: currentState.action.id,
        status: newStatus,
        reason: newStatus == ActionStatus.refused
            ? (currentState.newReason.fold(() => null, (final r) => r) ??
                currentState.action.reason)
            : null,
      );

      result.fold(
        (final l) => emit(ActionDetailLoadFailure(l.toString())),
        (final r) => emit(const ActionDetailUpdateSuccess()),
      );
    });
  }
}
