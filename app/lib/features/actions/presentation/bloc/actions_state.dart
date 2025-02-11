import 'package:app/features/actions/domain/action_summary.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ActionsState extends Equatable {
  const ActionsState();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionsInitial extends ActionsState {
  const ActionsInitial();
}

@immutable
final class ActionsLoadInProgress extends ActionsState {
  const ActionsLoadInProgress();
}

@immutable
final class ActionsLoadSuccess extends ActionsState {
  const ActionsLoadSuccess({required this.actions});

  final List<ActionSummary> actions;

  @override
  List<Object> get props => [actions];
}

@immutable
final class ActionsLoadFailure extends ActionsState {
  const ActionsLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
