import 'package:app/features/univers/domain/mission_liste.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/domain/value_objects/service_item.dart';
import 'package:equatable/equatable.dart';

final class UniversState extends Equatable {
  const UniversState({
    required this.univers,
    required this.thematiques,
    required this.services,
  });

  final TuileUnivers univers;
  final List<MissionListe> thematiques;
  final List<ServiceItem> services;

  UniversState copyWith({
    final TuileUnivers? univers,
    final List<MissionListe>? thematiques,
    final List<ServiceItem>? services,
  }) =>
      UniversState(
        univers: univers ?? this.univers,
        thematiques: thematiques ?? this.thematiques,
        services: services ?? this.services,
      );

  @override
  List<Object?> get props => [univers, thematiques, services];
}
