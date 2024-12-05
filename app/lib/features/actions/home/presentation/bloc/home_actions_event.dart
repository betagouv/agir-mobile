import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

sealed class HomeActionsEvent extends Equatable {
  const HomeActionsEvent();

  @override
  List<Object?> get props => [];
}

final class HomeActionsLoadRequested extends HomeActionsEvent {
  const HomeActionsLoadRequested(this.themeType);

  final ThemeType? themeType;

  @override
  List<Object?> get props => [themeType];
}
