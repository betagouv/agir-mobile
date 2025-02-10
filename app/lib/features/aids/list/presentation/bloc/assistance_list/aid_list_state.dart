import 'package:app/features/aids/core/domain/aid.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AidListState extends Equatable {
  const AidListState();

  @override
  List<Object?> get props => [];
}

@immutable
final class AidListInitial extends AidListState {
  const AidListInitial();
}

@immutable
final class AidListLoadInProgress extends AidListState {
  const AidListLoadInProgress();
}

@immutable
final class AidListLoadSuccess extends AidListState {
  const AidListLoadSuccess({
    required this.isCovered,
    required this.themes,
    required this.themeSelected,
  });

  final bool isCovered;
  final Map<ThemeType, List<Aid>> themes;
  final ThemeType? themeSelected;
  Map<ThemeType, List<Aid>> get currentTheme {
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
final class AidListLoadFailure extends AidListState {
  const AidListLoadFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
