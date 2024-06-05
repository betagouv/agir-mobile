import 'dart:async';

import 'package:app/src/fonctionnalites/authentification/domain/information_de_connexion.dart';
import 'package:app/src/fonctionnalites/authentification/domain/ports/authentification_repository.dart';
import 'package:app/src/fonctionnalites/se_connecter/bloc/se_connecter_event.dart';
import 'package:app/src/fonctionnalites/se_connecter/bloc/se_connecter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeConnecterBloc extends Bloc<SeConnecterEvent, SeConnecterState> {
  SeConnecterBloc({
    required final AuthentificationRepository authentificationRepository,
  })  : _authentificationRepository = authentificationRepository,
        super(const SeConnecterState()) {
    on<SeConnecterAdresseMailAChange>(_onAdresseMailAChange);
    on<SeConnecterMotDePasseAChange>(_onMotDePasseAChange);
    on<SeConnecterConnexionDemandee>(_onConnexionDemandee);
  }

  final AuthentificationRepository _authentificationRepository;

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
    final informationDeConnexion = InformationDeConnexion(
      adresseMail: state.adresseMail,
      motDePasse: state.motDePasse,
    );
    await _authentificationRepository
        .connectionDemandee(informationDeConnexion);
  }
}
