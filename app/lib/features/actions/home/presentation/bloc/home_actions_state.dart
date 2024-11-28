import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class HomeActionsState extends Equatable {
  const HomeActionsState();

  @override
  List<Object> get props => [];
}

@immutable
final class HomeActionsInitial extends HomeActionsState {
  const HomeActionsInitial();
}

@immutable
final class HomeActionsLoadSuccess extends HomeActionsState {
  const HomeActionsLoadSuccess({required this.actions});

  final List<ActionItem> actions;

  @override
  List<Object> get props => [actions];
}
