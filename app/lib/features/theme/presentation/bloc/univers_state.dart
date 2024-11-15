import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:app/features/theme/core/domain/service_item.dart';
import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

final class UniversState extends Equatable {
  const UniversState({
    required this.themeType,
    required this.missions,
    required this.services,
  });

  final ThemeType themeType;
  final List<MissionListe> missions;
  final List<ServiceItem> services;

  UniversState copyWith({
    final ThemeType? themeType,
    final List<MissionListe>? missions,
    final List<ServiceItem>? services,
  }) =>
      UniversState(
        themeType: themeType ?? this.themeType,
        missions: missions ?? this.missions,
        services: services ?? this.services,
      );

  @override
  List<Object?> get props => [themeType, missions, services];
}
