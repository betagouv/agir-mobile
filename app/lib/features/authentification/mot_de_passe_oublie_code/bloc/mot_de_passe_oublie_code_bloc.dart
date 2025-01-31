import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/authentification/mot_de_passe_oublie_code/bloc/mot_de_passe_oublie_code_event.dart';
import 'package:app/features/authentification/mot_de_passe_oublie_code/bloc/mot_de_passe_oublie_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class MotDePasseOublieCodeBloc
    extends Bloc<MotDePasseOublieCodeEvent, MotDePasseOublieCodeState> {
  MotDePasseOublieCodeBloc({
    required final AuthentificationRepository authentificationRepository,
    required final String email,
  }) : super(MotDePasseOublieCodeState.initialize(email: email)) {
    on<MotDePasseOublieCodeCodeChange>(
      (final event, final emit) => emit(state.copyWith(code: event.valeur)),
    );
    on<MotDePasseOublieCodeRenvoyerCodeDemande>(
      (final event, final emit) async {
        emit(state.copyWith(renvoyerCodeDemande: false));
        await authentificationRepository.renvoyerCodeDemande(state.email);
        emit(state.copyWith(renvoyerCodeDemande: true));
      },
    );
    on<MotDePasseOublieCodeMotDePasseChange>((final event, final emit) {
      emit(state.copyWith(motDePasse: event.valeur));
    });
    on<MotDePasseOublieCodeValidationDemande>((final event, final emit) async {
      final result = await authentificationRepository.modifierMotDePasse(
        email: state.email,
        code: state.code,
        motDePasse: state.motDePasse,
      );
      result.fold(
        (final exception) =>
            emit(state.copyWith(erreur: Some(exception.message))),
        (final _) => emit(state.copyWith(motDePasseModifie: true)),
      );
    });
  }
}
