import 'package:equatable/equatable.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

final class ThemeRecuperationDemandee extends ThemeEvent {
  const ThemeRecuperationDemandee(this.themeType);

  final String themeType;

  @override
  List<Object> get props => [themeType];
}
