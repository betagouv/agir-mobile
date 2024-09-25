import 'package:app/core/error/domain/api_erreur.dart';
import 'package:app/features/first_name/application/add_first_name.dart';
import 'package:app/features/first_name/presentation/bloc/first_name_event.dart';
import 'package:app/features/first_name/presentation/bloc/first_name_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstNameBloc extends Bloc<FirstNameEvent, FirstNameState> {
  FirstNameBloc(final AddFirstName addFirstName)
      : super(const FirstNameInitial()) {
    on<FirstNameChanged>((final event, final emit) {
      event.value.validate.fold(
        () => emit(FirstNameEntered(event.value)),
        (final t) => emit(FirstNameFailure(errorMessage: t)),
      );
    });
    on<FirstNameUpdatePressed>((final event, final emit) async {
      final currentState = state;
      if (currentState is FirstNameEntered) {
        emit(const FirstNameLoading());
        final result = await addFirstName(currentState.firstName);
        result.fold(
          (final l) => emit(
            FirstNameFailure(
              errorMessage: l is ApiErreur ? l.message : l.toString(),
            ),
          ),
          (final r) => emit(const FirstNameSuccess()),
        );
      }
    });
  }
}
