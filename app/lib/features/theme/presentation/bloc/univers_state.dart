import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_tile.dart';
import 'package:equatable/equatable.dart';

final class UniversState extends Equatable {
  const UniversState({
    required this.themeTile,
    required this.missions,
    required this.services,
  });

  final ThemeTile? themeTile;
  final List<MissionListe> missions;
  final List<ServiceItem> services;

  UniversState copyWith({
    final ThemeTile? themeTile,
    final List<MissionListe>? missions,
    final List<ServiceItem>? services,
  }) =>
      UniversState(
        themeTile: themeTile ?? this.themeTile,
        missions: missions ?? this.missions,
        services: services ?? this.services,
      );

  @override
  List<Object?> get props => [themeTile, missions, services];
}
