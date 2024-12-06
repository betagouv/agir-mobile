import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ActionListState extends Equatable {
  const ActionListState();

  @override
  List<Object> get props => [];
}

@immutable
final class ActionListInitial extends ActionListState {
  const ActionListInitial();
}

@immutable
final class ActionListLoading extends ActionListState {
  const ActionListLoading();
}

@immutable
final class ActionListSuccess extends ActionListState {
  const ActionListSuccess({required this.actions});

  final List<ActionItem> actions;

  @override
  List<Object> get props => [actions];
}

@immutable
final class ActionListFailure extends ActionListState {
  const ActionListFailure({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
