import 'package:app/features/actions/list/domain/action_item.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ActionsState extends Equatable {
  const ActionsState();

  @override
  List<Object?> get props => [];
}

@immutable
final class ActionsInitial extends ActionsState {
  const ActionsInitial();
}

@immutable
final class ActionsLoadSuccess extends ActionsState {
  const ActionsLoadSuccess({required this.themeType, required this.actions});

  final ThemeType? themeType;
  final List<ActionItem> actions;

  @override
  List<Object?> get props => [actions, themeType];
}
