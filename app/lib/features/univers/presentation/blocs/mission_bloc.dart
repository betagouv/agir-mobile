import 'package:app/features/gamification/domain/ports/gamification_port.dart';
import 'package:app/features/univers/domain/ports/univers_port.dart';
import 'package:app/features/univers/presentation/blocs/mission_event.dart';
import 'package:app/features/univers/presentation/blocs/mission_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  MissionBloc({
    required final UniversPort universPort,
    required final GamificationPort gamificationPort,
    required final String missionId,
  }) : super(const MissionInitial()) {
    on<MissionRecuperationDemandee>((final event, final emit) async {
      emit(const MissionChargement());
      final result = await universPort.recupererMission(missionId: missionId);
      result.fold(
        (final exception) => emit(const MissionErreur()),
        (final mission) =>
            emit(MissionSucces(mission: mission, estTerminee: false)),
      );
    });
    on<MissionGagnerPointsDemande>((final event, final emit) async {
      await universPort.gagnerPoints(id: event.id);
      final result = await universPort.recupererMission(
        missionId: missionId,
      );

      await gamificationPort.mettreAJourLesPoints();

      result.fold(
        (final exception) => emit(const MissionErreur()),
        (final mission) =>
            emit(MissionSucces(mission: mission, estTerminee: false)),
      );
    });
    on<MissionTerminerDemande>((final event, final emit) async {
      await universPort.terminer(missionId: missionId);
      final result = state as MissionSucces;
      emit(MissionSucces(mission: result.mission, estTerminee: true));
    });
  }
}
