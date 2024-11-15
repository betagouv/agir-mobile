import 'package:app/features/mission/actions/domain/mission_actions.dart';
import 'package:app/features/mission/actions/infrastructure/mission_actions_repository.dart';
import 'package:app/features/mission/actions/presentation/bloc/mission_actions_event.dart';
import 'package:app/features/mission/actions/presentation/bloc/mission_actions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionActionsBloc
    extends Bloc<MissionActionsEvent, MissionActionsState> {
  MissionActionsBloc({
    required final MissionActionsRepository missionActionsRepository,
  }) : super(
          const MissionActionsState(
            actions: MissionActions(
              values: [],
              canBeCompleted: false,
              isCompleted: false,
            ),
          ),
        ) {
    on<MissionActionRefreshRequested>((final event, final emit) async {
      final result = await missionActionsRepository.fetch(event.code);

      result.fold(
        (final l) => emit(
          const MissionActionsState(
            actions: MissionActions(
              values: [],
              canBeCompleted: false,
              isCompleted: false,
            ),
          ),
        ),
        (final r) => emit(MissionActionsState(actions: r)),
      );
    });
  }
}
