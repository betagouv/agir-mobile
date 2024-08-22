import 'package:app/features/authentification/creer_compte/presentation/blocs/creer_compte_event.dart';
import 'package:app/features/authentification/creer_compte/presentation/blocs/creer_compte_state.dart';
import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/domain/value_objects/information_de_connexion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class CreerCompteBloc extends Bloc<CreerCompteEvent, CreerCompteState> {
  CreerCompteBloc({required final AuthentificationPort authentificationPort})
      : _authentificationPort = authentificationPort,
        super(const CreerCompteState.empty()) {
    on<CreerCompteAdresseMailAChangee>(_onAdresseMailAChangee);
    on<CreerCompteMotDePasseAChange>(_onMotDePasseAChange);
    on<CreerCompteCreationDemandee>(_onCreationDemandee);
  }

  final AuthentificationPort _authentificationPort;

  void _onAdresseMailAChangee(
    final CreerCompteAdresseMailAChangee event,
    final Emitter<CreerCompteState> emit,
  ) {
    emit(state.copyWith(adresseMail: event.valeur));
  }

  void _onMotDePasseAChange(
    final CreerCompteMotDePasseAChange event,
    final Emitter<CreerCompteState> emit,
  ) {
    emit(state.copyWith(motDePasse: event.valeur));
  }

  Future<void> _onCreationDemandee(
    final CreerCompteCreationDemandee event,
    final Emitter<CreerCompteState> emit,
  ) async {
    final result = await _authentificationPort.creationDeCompteDemandee(
      InformationDeConnexion(
        adresseMail: state.adresseMail,
        motDePasse: state.motDePasse,
      ),
    );
    result.fold(
      (final exception) =>
          emit(state.copyWith(erreur: Some(exception.message))),
      (final _) => emit(state.copyWith(compteCree: true)),
    );
  }
}
