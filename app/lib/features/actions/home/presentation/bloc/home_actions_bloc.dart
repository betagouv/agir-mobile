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
        (final l) => emit(const HomeActionsLoadSuccess(actions: [])),
        (final r) => emit(HomeActionsLoadSuccess(actions: r)),
      );
    });
  }
}
