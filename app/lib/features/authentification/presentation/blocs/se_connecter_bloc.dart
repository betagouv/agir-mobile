import 'dart:async';

import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:app/features/authentification/presentation/blocs/se_connecter_event.dart';
import 'package:app/features/authentification/presentation/blocs/se_connecter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class SeConnecterBloc extends Bloc<SeConnecterEvent, SeConnecterState> {
  SeConnecterBloc({
    required final AuthentificationPort authentificationPort,
  })  : _authentificationPort = authentificationPort,
        super(const SeConnecterState.empty()) {
    on<SeConnecterAdresseMailAChange>(_onAdresseMailAChange);
    on<SeConnecterMotDePasseAChange>(_onMotDePasseAChange);
    on<SeConnecterConnexionDemandee>(_onConnexionDemandee);
  }

  final AuthentificationPort _authentificationPort;

  void _onAdresseMailAChange(
    final SeConnecterAdresseMailAChange event,
    final Emitter<SeConnecterState> emit,
  ) {
    emit(state.copyWith(adresseMail: event.valeur));
  }

  void _onMotDePasseAChange(
    final SeConnecterMotDePasseAChange event,
    final Emitter<SeConnecterState> emit,
  ) {
    emit(state.copyWith(motDePasse: event.valeur));
  }

  Future<void> _onConnexionDemandee(
    final SeConnecterConnexionDemandee event,
    final Emitter<SeConnecterState> emit,
  ) async {
    final result = await _authentificationPort.connexionDemandee(
      InformationDeConnexion(
        adresseMail: state.adresseMail,
        motDePasse: state.motDePasse,
      ),
    );

    result.fold(
      (final exception) =>
          emit(state.copyWith(erreur: Some(exception.message))),
      (final _) => emit(state.copyWith(connexionFaite: true)),
    );
  }
}
