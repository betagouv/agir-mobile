import 'package:app/features/assistances/core/domain/aide.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AssistanceListState extends Equatable {
  const AssistanceListState();

  @override
  List<Object?> get props => [];
}

@immutable
final class AssistanceListInitial extends AssistanceListState {
  const AssistanceListInitial();
}

@immutable
final class AssistanceListLoadInProgress extends AssistanceListState {
  const AssistanceListLoadInProgress();
}

@immutable
final class AssistanceListLoadSuccess extends AssistanceListState {
  const AssistanceListLoadSuccess({
    required this.isCovered,
    required this.themes,
    required this.themeSelected,
  });

  final bool isCovered;
  final Map<ThemeType, List<Assistance>> themes;
  final ThemeType? themeSelected;
  Map<ThemeType, List<Assistance>> get currentTheme {
    if (themeSelected == null) {
      return themes;
    }

    return themes.containsKey(themeSelected)
        ? {themeSelected!: themes[themeSelected]!}
        : {};
  }

  @override
  List<Object?> get props => [isCovered, themes, themeSelected];
}

@immutable
final class AssistanceListLoadFailure extends AssistanceListState {
  const AssistanceListLoadFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
