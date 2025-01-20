import 'package:app/features/actions/section/infrastructure/actions_repository.dart';
import 'package:app/features/actions/section/presentation/bloc/actions_event.dart';
import 'package:app/features/actions/section/presentation/bloc/actions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  ActionsBloc({required final ActionsRepository repository})
      : super(const ActionsInitial()) {
    on<ActionsLoadRequested>((final event, final emit) async {
      final result = await repository.fetch(themeType: event.themeType);
      result.fold(
        (final l) => emit(
          ActionsLoadSuccess(themeType: event.themeType, actions: const []),
        ),
        (final r) => emit(
          ActionsLoadSuccess(themeType: event.themeType, actions: r),
        ),
      );
    });
    on<ActionsRefreshRequested>((final event, final emit) async {
      switch (state) {
        case ActionsInitial():
          return;
        case final ActionsLoadSuccess aState:
          final result = await repository.fetch(themeType: aState.themeType);
          emit(
            ActionsLoadSuccess(
              themeType: aState.themeType,
              actions: result.fold((final l) => const [], (final r) => r),
            ),
          );
      }
    });
  }
}
