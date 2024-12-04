import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

sealed class KnowYourCustomersEvent extends Equatable {
  const KnowYourCustomersEvent();

  @override
  List<Object?> get props => [];
}

final class KnowYourCustomersStarted extends KnowYourCustomersEvent {
  const KnowYourCustomersStarted();

  @override
  List<Object> get props => [];
}

final class KnowYourCustomersRefreshNeed extends KnowYourCustomersEvent {
  const KnowYourCustomersRefreshNeed();

  @override
  List<Object> get props => [];
}

final class KnowYourCustomersThemePressed extends KnowYourCustomersEvent {
  const KnowYourCustomersThemePressed(this.theme);

  final Option<ThemeType> theme;

  @override
  List<Object?> get props => [theme];
}
