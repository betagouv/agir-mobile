import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/authentification/core/domain/information_de_code.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_event.dart';
import 'package:app/features/authentification/saisie_code/presentation/bloc/saisie_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class SaisieCodeBloc extends Bloc<SaisieCodeEvent, SaisieCodeState> {
  SaisieCodeBloc({
    required final AuthentificationPort authentificationPort,
    required final String email,
  }) : super(
          SaisieCodeState(
            email: email,
            renvoyerCodeDemande: false,
            erreur: const None(),
          ),
        ) {
    on<SaiseCodeRenvoyerCodeDemandee>((final event, final emit) async {
      emit(state.copyWith(renvoyerCodeDemande: false));
      await authentificationPort.renvoyerCodeDemande(state.email);
      emit(state.copyWith(renvoyerCodeDemande: true));
    });
    on<SaisieCodeCodeSaisie>((final event, final emit) async {
      if (event.code.length != 6) {
        return;
      }

      final result = await authentificationPort.validationDemandee(
        InformationDeCode(adresseMail: state.email, code: event.code),
      );

      result.fold(
        (final exception) =>
            emit(state.copyWith(erreur: Some(exception.message))),
        (final _) {},
      );
    });
  }
}
