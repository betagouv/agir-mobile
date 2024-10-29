import 'package:app/features/theme/core/domain/mission_liste.dart';
import 'package:equatable/equatable.dart';

sealed class MissionHomeState extends Equatable {
  const MissionHomeState();

  @override
  List<Object> get props => [];
}

final class MissionHomeInitial extends MissionHomeState {
  const MissionHomeInitial();
}

final class MissionHomeLoadSuccess extends MissionHomeState {
  const MissionHomeLoadSuccess(this.missions);

  final List<MissionListe> missions;

  @override
  List<Object> get props => [missions];
}
