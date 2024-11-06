import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

sealed class AssistanceListEvent extends Equatable {
  const AssistanceListEvent();

  @override
  List<Object?> get props => [];
}

final class AssistanceListFetch extends AssistanceListEvent {
  const AssistanceListFetch();
}

final class AssistanceListThemeSelected extends AssistanceListEvent {
  const AssistanceListThemeSelected(this.value);

  final ThemeType? value;

  @override
  List<Object?> get props => [value];
}
