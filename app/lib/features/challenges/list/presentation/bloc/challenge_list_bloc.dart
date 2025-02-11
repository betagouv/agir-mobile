import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/challenges/list/application/fetch_challenges.dart';
import 'package:app/features/challenges/list/presentation/bloc/challenge_list_event.dart';
import 'package:app/features/challenges/list/presentation/bloc/challenge_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeListBloc extends Bloc<ChallengeListEvent, ChallengeListState> {
  ChallengeListBloc(final FetchChallenges useCase)
      : super(const ChallengeListInitial()) {
    on<ChallengeListFetch>((final event, final emit) async {
      emit(const ChallengeListLoading());
      final result = await useCase();
      result.fold(
        (final l) => emit(
          ChallengeListFailure(
            errorMessage: l is ApiErreur ? l.message : l.toString(),
          ),
        ),
        (final r) => emit(ChallengeListSuccess(challenges: r)),
      );
    });
  }
}
