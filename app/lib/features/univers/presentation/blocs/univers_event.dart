import 'package:equatable/equatable.dart';

sealed class UniversEvent extends Equatable {
  const UniversEvent();

  @override
  List<Object> get props => [];
}

final class UniversThematiquesRecuperationDemandee extends UniversEvent {
  const UniversThematiquesRecuperationDemandee(this.universType);

  final String universType;

  @override
  List<Object> get props => [universType];
}
