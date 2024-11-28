import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class HomeActionsEvent extends Equatable {
  const HomeActionsEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class HomeActionsLoadRequested extends HomeActionsEvent {
  const HomeActionsLoadRequested(this.themeType);

  final ThemeType? themeType;

  @override
  List<Object?> get props => [themeType];
}
