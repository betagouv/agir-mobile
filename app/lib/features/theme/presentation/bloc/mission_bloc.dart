import 'package:app/features/gamification/domain/gamification_port.dart';
import 'package:app/features/theme/core/domain/theme_port.dart';
import 'package:app/features/theme/presentation/bloc/mission_event.dart';
import 'package:app/features/theme/presentation/bloc/mission_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  MissionBloc({
    required final ThemePort themePort,
    required final GamificationPort gamificationPort,
    required final String missionId,
  }) : super(const MissionInitial()) {
    on<MissionRecuperationDemandee>((final event, final emit) async {
      emit(const MissionChargement());
      final result = await themePort.recupererMission(missionId: missionId);
      result.fold(
        (final exception) => emit(const MissionErreur()),
        (final mission) =>
            emit(MissionSucces(mission: mission, estTerminee: false)),
      );
    });
    on<MissionGagnerPointsDemande>((final event, final emit) async {
      await themePort.gagnerPoints(id: event.id);
      final result = await themePort.recupererMission(missionId: missionId);

      await gamificationPort.mettreAJourLesPoints();

      result.fold(
        (final exception) => emit(const MissionErreur()),
        (final mission) =>
            emit(MissionSucces(mission: mission, estTerminee: false)),
      );
    });
    on<MissionTerminerDemande>((final event, final emit) async {
      await themePort.terminer(missionId: missionId);
      final result = state as MissionSucces;
      emit(MissionSucces(mission: result.mission, estTerminee: true));
    });
  }
}
