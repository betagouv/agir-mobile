import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie/mot_de_passe_oublie_event.dart';
import 'package:app/features/authentification/mot_de_passe_oublie/blocs/mot_de_passe_oublie/mot_de_passe_oublie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MotDePasseOublieBloc
    extends Bloc<MotDePasseOublieEvent, MotDePasseOublieState> {
  MotDePasseOublieBloc({
    required final AuthentificationPort authentificationPort,
  })  : _authentificationPort = authentificationPort,
        super(const MotDePasseOublieState(email: '')) {
    on<MotDePasseOublieEmailChange>(_onEmailChange);
    on<MotDePasseOublieValider>(_onValider);
  }

  final AuthentificationPort _authentificationPort;

  void _onEmailChange(
    final MotDePasseOublieEmailChange event,
    final Emitter<MotDePasseOublieState> emit,
  ) {
    emit(state.copyWith(email: event.valeur));
  }

  Future<void> _onValider(
    final MotDePasseOublieValider event,
    final Emitter<MotDePasseOublieState> emit,
  ) async {
    await _authentificationPort.oubliMotDePasse(state.email);
  }
}
