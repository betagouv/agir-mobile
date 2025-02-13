import 'package:app/features/mission/mission/infrastructure/mission_repository.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_event.dart';
import 'package:app/features/mission/mission/presentation/bloc/mission_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  MissionBloc({required final MissionRepository missionRepository}) : super(const MissionInitial()) {
    on<MissionLoadRequested>((final event, final emit) async {
      emit(const MissionLoading());
      final mission = await missionRepository.fetch(event.code);
      mission.fold(
        (final l) => emit(const MissionFailure(errorMessage: 'Erreur lors du chargement')),
        (final r) => emit(MissionSuccess(mission: r, index: 0)),
      );
    });
    on<MissionPreviousRequested>((final event, final emit) {
      final aState = state;
      if (aState is MissionSuccess) {
        emit(aState.previous());
      }
    });
    on<MissionNextRequested>((final event, final emit) async {
      final aState = state;
      if (aState is MissionSuccess) {
        emit(aState.next());
      }
    });
    on<MissionCompleteRequested>((final event, final emit) async {
      final aState = state;
      if (aState is MissionSuccess) {
        await missionRepository.complete(aState.code);
        emit(aState.next());
      }
    });
  }
}
