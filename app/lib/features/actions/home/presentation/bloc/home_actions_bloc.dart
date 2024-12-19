import 'package:app/features/actions/home/infrastructure/home_actions_repository.dart';
import 'package:app/features/actions/home/presentation/bloc/home_actions_event.dart';
import 'package:app/features/actions/home/presentation/bloc/home_actions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeActionsBloc extends Bloc<HomeActionsEvent, HomeActionsState> {
  HomeActionsBloc({required final HomeActionsRepository repository})
      : super(const HomeActionsInitial()) {
    on<HomeActionsLoadRequested>((final event, final emit) async {
      final result = await repository.fetch(themeType: event.themeType);
      result.fold(
        (final l) => emit(
          HomeActionsLoadSuccess(
            themeType: event.themeType,
            actions: const [],
          ),
        ),
        (final r) => emit(
          HomeActionsLoadSuccess(themeType: event.themeType, actions: r),
        ),
      );
    });
    on<HomeActionsRefreshRequested>((final event, final emit) async {
      switch (state) {
        case HomeActionsInitial():
          return;
        case final HomeActionsLoadSuccess aState:
          final result = await repository.fetch(themeType: aState.themeType);
          emit(
            HomeActionsLoadSuccess(
              themeType: aState.themeType,
              actions: result.fold((final l) => const [], (final r) => r),
            ),
          );
      }
    });
  }
}
