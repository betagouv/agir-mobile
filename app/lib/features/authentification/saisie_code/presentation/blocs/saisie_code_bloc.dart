import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_code.dart';
import 'package:app/features/authentification/saisie_code/presentation/blocs/saisie_code_event.dart';
import 'package:app/features/authentification/saisie_code/presentation/blocs/saisie_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class SaisieCodeBloc extends Bloc<SaisieCodeEvent, SaisieCodeState> {
  SaisieCodeBloc({
    required final AuthentificationPort authentificationPort,
    required final String email,
  })  : _authentificationPort = authentificationPort,
        super(
          SaisieCodeState(
            email: email,
            renvoyerCodeDemandee: false,
            erreur: const None(),
          ),
        ) {
    on<SaiseCodeRenvoyerCodeDemandee>(_onRenvoyerCodeDemandee);
    on<SaisieCodeCodeSaisie>(_onCodeSaisie);
  }

  final AuthentificationPort _authentificationPort;

  Future<void> _onRenvoyerCodeDemandee(
    final SaiseCodeRenvoyerCodeDemandee event,
    final Emitter<SaisieCodeState> emit,
  ) async {
    emit(state.copyWith(renvoyerCodeDemandee: false));
    await _authentificationPort.renvoyerCodeDemandee(state.email);
    emit(state.copyWith(renvoyerCodeDemandee: true));
  }

  Future<void> _onCodeSaisie(
    final SaisieCodeCodeSaisie event,
    final Emitter<SaisieCodeState> emit,
  ) async {
    if (event.code.length != 6) {
      return;
    }

    final result = await _authentificationPort.validationDemandee(
      InformationDeCode(adresseMail: state.email, code: event.code),
    );

    result.fold(
      (final exception) =>
          emit(state.copyWith(erreur: Some(exception.message))),
      (final _) {},
    );
  }
}
