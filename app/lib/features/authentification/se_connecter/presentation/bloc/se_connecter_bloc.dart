import 'package:app/features/authentification/core/domain/information_de_connexion.dart';
import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_event.dart';
import 'package:app/features/authentification/se_connecter/presentation/bloc/se_connecter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class SeConnecterBloc extends Bloc<SeConnecterEvent, SeConnecterState> {
  SeConnecterBloc({
    required final AuthentificationRepository authentificationRepository,
  }) : super(const SeConnecterState.empty()) {
    on<SeConnecterAdresseMailAChange>(
      (final event, final emit) =>
          emit(state.copyWith(adresseMail: event.valeur)),
    );
    on<SeConnecterMotDePasseAChange>((final event, final emit) {
      emit(state.copyWith(motDePasse: event.valeur));
    });
    on<SeConnecterConnexionDemandee>((final event, final emit) async {
      emit(state.copyWith(connexionFaite: false));
      final result = await authentificationRepository.connexionDemandee(
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
    });
  }
}
