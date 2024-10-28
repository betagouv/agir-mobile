import 'package:app/features/theme/core/domain/mission.dart';
import 'package:equatable/equatable.dart';

sealed class MissionState extends Equatable {
  const MissionState();

  @override
  List<Object> get props => [];
}

final class MissionInitial extends MissionState {
  const MissionInitial();
}

final class MissionChargement extends MissionState {
  const MissionChargement();
}

final class MissionSucces extends MissionState {
  const MissionSucces({required this.mission, required this.estTerminee});

  final Mission mission;
  final bool estTerminee;

  @override
  List<Object> get props => [mission, estTerminee];
}

final class MissionErreur extends MissionState {
  const MissionErreur();
}
