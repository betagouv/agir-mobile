import 'package:app/features/mission/challenges/domain/mission_challenges.dart';
import 'package:app/features/mission/challenges/infrastructure/mission_challenges_repository.dart';
import 'package:app/features/mission/challenges/presentation/bloc/mission_challenges_event.dart';
import 'package:app/features/mission/challenges/presentation/bloc/mission_challenges_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MissionChallengesBloc
    extends Bloc<MissionChallengesEvent, MissionChallengesState> {
  MissionChallengesBloc({required final MissionChallengesRepository repository})
    : super(
        const MissionChallengesState(
          challenges: MissionChallenges(
            values: [],
            canBeCompleted: false,
            isCompleted: false,
          ),
        ),
      ) {
    on<MissionChallengesRefreshRequested>((final event, final emit) async {
      final result = await repository.fetch(event.code);

      result.fold(
        (final l) => emit(
          const MissionChallengesState(
            challenges: MissionChallenges(
              values: [],
              canBeCompleted: false,
              isCompleted: false,
            ),
          ),
        ),
        (final r) => emit(MissionChallengesState(challenges: r)),
      );
    });
  }
}
