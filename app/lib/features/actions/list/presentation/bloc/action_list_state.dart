import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:equatable/equatable.dart';

sealed class ActionListState extends Equatable {
  const ActionListState();

  @override
  List<Object> get props => [];
}

final class ActionListInitial extends ActionListState {
  const ActionListInitial();
}

final class ActionListLoading extends ActionListState {
  const ActionListLoading();
}

final class ActionListSuccess extends ActionListState {
  const ActionListSuccess({required this.actions});

  final List<ActionItem> actions;

  @override
  List<Object> get props => [actions];
}

final class ActionListFailure extends ActionListState {
  const ActionListFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
