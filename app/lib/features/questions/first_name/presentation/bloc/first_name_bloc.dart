import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/questions/first_name/infrastructure/first_name_repository.dart';
import 'package:app/features/questions/first_name/presentation/bloc/first_name_event.dart';
import 'package:app/features/questions/first_name/presentation/bloc/first_name_state.dart';
import 'package:clock/clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstNameBloc extends Bloc<FirstNameEvent, FirstNameState> {
  FirstNameBloc({required final FirstNameRepository repository, required final Clock clock}) : super(const FirstNameInitial()) {
    on<FirstNameChanged>((final event, final emit) {
      event.value.validate.fold(() => emit(FirstNameEntered(event.value)), (final t) => emit(FirstNameFailure(errorMessage: t)));
    });
    on<FirstNameSubmitted>((final event, final emit) async {
      final currentState = state;
      switch (currentState) {
        case FirstNameEntered():
          emit(const FirstNameLoading());
          final result = await repository.addFirstName(currentState.firstName);
          result.fold(
            (final l) => emit(FirstNameFailure(errorMessage: l is ApiErreur ? l.message : l.toString())),
            (final r) => emit(FirstNameSuccess(DateTime.now())),
          );

          return;
        case FirstNameSuccess():
          emit(FirstNameSuccess(clock.now()));

          return;
        case FirstNameInitial():
        case FirstNameLoading():
        case FirstNameFailure():
          return;
      }
    });
  }
}
