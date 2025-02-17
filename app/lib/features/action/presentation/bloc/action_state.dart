import 'package:app/features/action/domain/action.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ActionState extends Equatable {
  const ActionState();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionInitial extends ActionState {
  const ActionInitial();
}

@immutable
final class ActionLoadInProgress extends ActionState {
  const ActionLoadInProgress();
}

@immutable
final class ActionLoadSuccess extends ActionState {
  const ActionLoadSuccess({required this.action});

  final Action action;

  @override
  List<Object> get props => [action];
}

@immutable
final class ActionLoadFailure extends ActionState {
  const ActionLoadFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
