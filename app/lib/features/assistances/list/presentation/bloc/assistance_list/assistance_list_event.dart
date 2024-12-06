import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class AssistanceListEvent extends Equatable {
  const AssistanceListEvent();

  @override
  List<Object?> get props => [];
}

@immutable
final class AssistanceListFetch extends AssistanceListEvent {
  const AssistanceListFetch();
}

@immutable
final class AssistanceListThemeSelected extends AssistanceListEvent {
  const AssistanceListThemeSelected(this.value);

  final ThemeType? value;

  @override
  List<Object?> get props => [value];
}
