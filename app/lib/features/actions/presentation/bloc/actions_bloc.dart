import 'package:app/features/actions/infrastructure/actions_repository.dart';
import 'package:app/features/actions/presentation/bloc/actions_event.dart';
import 'package:app/features/actions/presentation/bloc/actions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  ActionsBloc({required final ActionsRepository repository})
      : super(const ActionsInitial()) {
    on<ActionsLoadRequested>((final event, final emit) async {
      emit(const ActionsLoadInProgress());
      final result = await repository.fetch();

      emit(
        result.fold(
          (final l) => ActionsLoadFailure(errorMessage: l.toString()),
          (final r) => ActionsLoadSuccess(actions: r),
        ),
      );
    });
  }
}
