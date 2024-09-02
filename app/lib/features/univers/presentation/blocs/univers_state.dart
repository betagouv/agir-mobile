import 'package:app/features/univers/domain/mission_liste.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:equatable/equatable.dart';

final class UniversState extends Equatable {
  const UniversState({required this.univers, required this.thematiques});

  final TuileUnivers univers;
  final List<MissionListe> thematiques;

  UniversState copyWith({
    final TuileUnivers? univers,
    final List<MissionListe>? thematiques,
  }) =>
      UniversState(
        univers: univers ?? this.univers,
        thematiques: thematiques ?? this.thematiques,
      );

  @override
  List<Object?> get props => [univers, thematiques];
}
