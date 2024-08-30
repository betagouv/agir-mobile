import 'dart:async';

import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie_code/mot_de_passe_oublie_code_event.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie_code/mot_de_passe_oublie_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class MotDePasseOublieCodeBloc
    extends Bloc<MotDePasseOublieCodeEvent, MotDePasseOublieCodeState> {
  MotDePasseOublieCodeBloc({
    required final AuthentificationPort authentificationPort,
    required final String email,
  })  : _authentificationPort = authentificationPort,
        super(MotDePasseOublieCodeState.initialize(email: email)) {
    on<MotDePasseOublieCodeCodeChange>(_onCodeChange);
    on<MotDePasseOublieCodeRenvoyerCodeDemande>(_onRenvoyerCodeDemande);
    on<MotDePasseOublieCodeMotDePasseChange>(_motDePasseChange);
    on<MotDePasseOublieCodeValidationDemande>(_onValidationDemande);
  }

  final AuthentificationPort _authentificationPort;

  void _onCodeChange(
    final MotDePasseOublieCodeCodeChange event,
    final Emitter<MotDePasseOublieCodeState> emit,
  ) {
    emit(state.copyWith(code: event.valeur));
  }

  Future<void> _onRenvoyerCodeDemande(
    final MotDePasseOublieCodeRenvoyerCodeDemande event,
    final Emitter<MotDePasseOublieCodeState> emit,
  ) async {
    emit(state.copyWith(renvoyerCodeDemande: false));
    await _authentificationPort.renvoyerCodeDemande(state.email);
    emit(state.copyWith(renvoyerCodeDemande: true));
  }

  void _motDePasseChange(
    final MotDePasseOublieCodeMotDePasseChange event,
    final Emitter<MotDePasseOublieCodeState> emit,
  ) {
    emit(state.copyWith(motDePasse: event.valeur));
  }

  Future<void> _onValidationDemande(
    final MotDePasseOublieCodeValidationDemande event,
    final Emitter<MotDePasseOublieCodeState> emit,
  ) async {
    final result = await _authentificationPort.modifierMotDePasse(
      email: state.email,
      code: state.code,
      motDePasse: state.motDePasse,
    );
    result.fold(
      (final exception) =>
          emit(state.copyWith(erreur: Some(exception.message))),
      (final _) => emit(state.copyWith(motDePasseModifie: true)),
    );
  }
}
