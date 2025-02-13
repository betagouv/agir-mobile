import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum GamificationStatut { initial, chargement, succes, erreur }

@immutable
final class GamificationState extends Equatable {
  const GamificationState({required this.statut, required this.points});

  const GamificationState.empty() : this(statut: GamificationStatut.initial, points: 0);

  final GamificationStatut statut;
  final int points;

  GamificationState copyWith({final GamificationStatut? statut, final int? points}) =>
      GamificationState(statut: statut ?? this.statut, points: points ?? this.points);

  @override
  List<Object> get props => [statut, points];
}
