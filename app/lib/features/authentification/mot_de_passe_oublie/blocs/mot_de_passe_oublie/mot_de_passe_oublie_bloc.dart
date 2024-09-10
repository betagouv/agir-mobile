import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie/mot_de_passe_oublie_event.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie/mot_de_passe_oublie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotDePasseOublieBloc
    extends Bloc<MotDePasseOublieEvent, MotDePasseOublieState> {
  MotDePasseOublieBloc({
    required final AuthentificationPort authentificationPort,
  }) : super(const MotDePasseOublieState(email: '')) {
    on<MotDePasseOublieEmailChange>(
      (final event, final emit) => emit(state.copyWith(email: event.valeur)),
    );
    on<MotDePasseOublieValider>(
      (final event, final emit) async =>
          authentificationPort.oubliMotDePasse(state.email),
    );
  }
}
