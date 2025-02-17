import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

@immutable
final class ThemeRecuperationDemandee extends ThemeEvent {
  const ThemeRecuperationDemandee(this.themeType);

  final ThemeType themeType;

  @override
  List<Object> get props => [themeType];
}
