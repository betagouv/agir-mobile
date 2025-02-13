import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/know_your_customer/list/infrastructure/know_your_customers_repository.dart';
import 'package:app/features/know_your_customer/list/presentation/bloc/know_your_customers_event.dart';
import 'package:app/features/know_your_customer/list/presentation/bloc/know_your_customers_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KnowYourCustomersBloc
    extends Bloc<KnowYourCustomersEvent, KnowYourCustomersState> {
  KnowYourCustomersBloc({required final KnowYourCustomersRepository repository})
    : super(const KnowYourCustomersInitial()) {
    on<KnowYourCustomersStarted>((final event, final emit) async {
      emit(const KnowYourCustomersLoading());
      final result = await repository.fetchQuestions();
      result.fold(
        (final l) => emit(
          KnowYourCustomersFailure(
            errorMessage: l is ApiErreur ? l.message : l.toString(),
          ),
        ),
        (final r) => emit(KnowYourCustomersSuccess(allQuestions: r)),
      );
    });
    on<KnowYourCustomersRefreshNeed>((final event, final emit) async {
      final aState = state;
      if (aState is KnowYourCustomersSuccess) {
        final result = await repository.fetchQuestions();
        result.fold(
          (final l) => emit(
            KnowYourCustomersFailure(
              errorMessage: l is ApiErreur ? l.message : l.toString(),
            ),
          ),
          (final r) => emit(aState.copyWith(allQuestions: r)),
        );
      }
    });
    on<KnowYourCustomersThemePressed>((final event, final emit) async {
      final aState = state;
      if (aState is KnowYourCustomersSuccess) {
        emit(aState.copyWith(themeSelected: event.theme));
      }
    });
  }
}
