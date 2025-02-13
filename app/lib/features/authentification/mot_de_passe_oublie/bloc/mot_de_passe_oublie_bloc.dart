import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/bloc/mot_de_passe_oublie_event.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/bloc/mot_de_passe_oublie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotDePasseOublieBloc extends Bloc<MotDePasseOublieEvent, MotDePasseOublieState> {
  MotDePasseOublieBloc({required final AuthentificationRepository authentificationRepository})
    : super(const MotDePasseOublieState(email: '')) {
    on<MotDePasseOublieEmailChange>((final event, final emit) => emit(state.copyWith(email: event.valeur)));
    on<MotDePasseOublieValider>((final event, final emit) async => authentificationRepository.oubliMotDePasse(state.email));
  }
}
