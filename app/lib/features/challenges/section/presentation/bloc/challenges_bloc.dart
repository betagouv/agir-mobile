import 'package:app/features/challenges/section/infrastructure/challenges_repository.dart';
import 'package:app/features/challenges/section/presentation/bloc/challenges_event.dart';
import 'package:app/features/challenges/section/presentation/bloc/challenges_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  ChallengesBloc({required final ChallengesRepository repository})
    : super(const ChallengesInitial()) {
    on<ChallengesLoadRequested>((final event, final emit) async {
      final result = await repository.fetch(themeType: event.themeType);
      result.fold(
        (final l) => emit(
          ChallengesLoadSuccess(
            themeType: event.themeType,
            challenges: const [],
          ),
        ),
        (final r) => emit(
          ChallengesLoadSuccess(themeType: event.themeType, challenges: r),
        ),
      );
    });
    on<ChallengesRefreshRequested>((final event, final emit) async {
      switch (state) {
        case ChallengesInitial():
          return;
        case final ChallengesLoadSuccess aState:
          final result = await repository.fetch(themeType: aState.themeType);
          emit(
            ChallengesLoadSuccess(
              themeType: aState.themeType,
              challenges: result.fold((final l) => const [], (final r) => r),
            ),
          );
      }
    });
  }
}
