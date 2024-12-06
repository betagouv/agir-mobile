import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ThemeRecuperationDemandee extends ThemeEvent {
  const ThemeRecuperationDemandee(this.themeType);

  final String themeType;

  @override
  List<Object> get props => [themeType];
}
