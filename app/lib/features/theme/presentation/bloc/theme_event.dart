import 'package:equatable/equatable.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

final class UniversRecuperationDemandee extends ThemeEvent {
  const UniversRecuperationDemandee(this.themeType);

  final String themeType;

  @override
  List<Object> get props => [themeType];
}
