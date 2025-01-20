import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ActionsEvent extends Equatable {
  const ActionsEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class ActionsLoadRequested extends ActionsEvent {
  const ActionsLoadRequested(this.themeType);

  final ThemeType? themeType;

  @override
  List<Object?> get props => [themeType];
}

@immutable
final class ActionsRefreshRequested extends ActionsEvent {
  const ActionsRefreshRequested();

  @override
  List<Object?> get props => [];
}
