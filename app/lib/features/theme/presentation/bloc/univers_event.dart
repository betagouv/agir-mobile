import 'package:equatable/equatable.dart';

sealed class UniversEvent extends Equatable {
  const UniversEvent();

  @override
  List<Object> get props => [];
}

final class UniversRecuperationDemandee extends UniversEvent {
  const UniversRecuperationDemandee(this.themeType);

  final String themeType;

  @override
  List<Object> get props => [themeType];
}
