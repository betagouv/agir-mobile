import 'package:app/features/actions/core/domain/action_status.dart';
import 'package:app/features/actions/detail/domain/action.dart';
import 'package:app/l10n/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

sealed class ActionDetailState extends Equatable {
  const ActionDetailState();

  @override
  List<Object?> get props => [];
}

final class ActionDetailInitial extends ActionDetailState {
  const ActionDetailInitial();
}

final class ActionDetailLoadInProgress extends ActionDetailState {
  const ActionDetailLoadInProgress();
}

final class ActionDetailLoadSuccess extends ActionDetailState {
  const ActionDetailLoadSuccess({
    required this.action,
    this.newStatus,
    this.newReason = const None(),
  });

  final Action action;
  final ActionStatus? newStatus;
  final Option<String?> newReason;

  String get acceptanceText => _getRadioButtonText(
        initialStatus: Localisation.jeReleveLeDefi,
        progressStatus: Localisation.defiRealise,
      );

  String get refusalText => _getRadioButtonText(
        initialStatus: Localisation.pasPourMoi,
        progressStatus: Localisation.finalementPasPourMoi,
      );

  String _getRadioButtonText({
    required final String initialStatus,
    required final String progressStatus,
  }) =>
      switch (action.status) {
        ActionStatus.toDo || ActionStatus.refused => initialStatus,
        ActionStatus.inProgress ||
        ActionStatus.alreadyDone ||
        ActionStatus.abandonned ||
        ActionStatus.done =>
          progressStatus,
      };

  bool? get isAccepted => switch (newStatus ?? action.status) {
        ActionStatus.toDo || ActionStatus.inProgress => null,
        ActionStatus.abandonned || ActionStatus.refused => false,
        ActionStatus.alreadyDone || ActionStatus.done => true,
      };

  ActionDetailLoadSuccess copyWith({
    final Action? action,
    final ActionStatus? newStatus,
    final Option<String?>? newReason,
  }) =>
      ActionDetailLoadSuccess(
        action: action ?? this.action,
        newStatus: newStatus ?? this.newStatus,
        newReason: newReason ?? this.newReason,
      );

  @override
  List<Object?> get props => [action, newStatus, newReason];
}

final class ActionDetailLoadFailure extends ActionDetailState {
  const ActionDetailLoadFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class ActionDetailUpdateSuccess extends ActionDetailState {
  const ActionDetailUpdateSuccess();
}

final class ActionDetailUpdateIgnored extends ActionDetailState {
  const ActionDetailUpdateIgnored();
}
