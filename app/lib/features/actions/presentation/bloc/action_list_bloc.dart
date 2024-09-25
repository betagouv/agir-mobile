import 'package:app/features/actions/application/use_cases/fetch_actions.dart';
import 'package:app/features/actions/presentation/bloc/action_list_event.dart';
import 'package:app/features/actions/presentation/bloc/action_list_state.dart';
import 'package:app/shared/domain/entities/api_erreur.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionListBloc extends Bloc<ActionListEvent, ActionListState> {
  ActionListBloc(final FetchActions fetchActions)
      : super(const ActionListInitial()) {
    on<ActionListFetch>((final event, final emit) async {
      emit(const ActionListLoading());
      final result = await fetchActions();
      result.fold(
        (final l) => emit(
          ActionListFailure(
            errorMessage: l is ApiErreur ? l.message : l.toString(),
          ),
        ),
        (final r) => emit(ActionListSuccess(actions: r)),
      );
    });
  }
}