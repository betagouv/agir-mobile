import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_event.dart';
import 'package:app/features/authentification/creer_compte/presentation/bloc/creer_compte_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class CreerCompteBloc extends Bloc<CreerCompteEvent, CreerCompteState> {
  CreerCompteBloc({required final AuthentificationPort authentificationPort})
      : super(const CreerCompteState.empty()) {
    on<CreerCompteAdresseMailAChangee>((final event, final emit) {
      emit(state.copyWith(adresseMail: event.valeur));
    });
    on<CreerCompteMotDePasseAChange>((final event, final emit) {
      emit(state.copyWith(motDePasse: event.valeur));
    });
    on<CreerCompteCguAChange>((final event, final emit) {
      emit(state.copyWith(aCguAcceptees: event.valeur));
    });
    on<CreerCompteCreationDemandee>((final event, final emit) async {
      emit(state.copyWith(compteCree: false));
      final result = await authentificationPort.creationDeCompteDemandee(
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
    });
  }
}
