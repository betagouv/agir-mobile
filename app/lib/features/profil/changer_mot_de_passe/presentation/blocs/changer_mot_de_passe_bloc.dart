import 'package:app/features/profil/changer_mot_de_passe/presentation/blocs/changer_mot_de_passe_event.dart';
import 'package:app/features/profil/changer_mot_de_passe/presentation/blocs/changer_mot_de_passe_state.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangerMotDePasseBloc
    extends Bloc<ChangerMotDePasseEvent, ChangerMotDePasseState> {
  ChangerMotDePasseBloc({required final ProfilPort profilPort})
      : _profilPort = profilPort,
        super(const ChangerMotDePasseState.empty()) {
    on<ChangerMotDePasseAChange>(_onMotPasseChange);
    on<ChangerMotDePasseChangementDemande>(_onChangementDemande);
  }

  void _onMotPasseChange(
    final ChangerMotDePasseAChange event,
    final Emitter<ChangerMotDePasseState> emit,
  ) {
    emit(state.copyWith(motDePasse: event.valeur));
  }

  Future<void> _onChangementDemande(
    final ChangerMotDePasseChangementDemande event,
    final Emitter<ChangerMotDePasseState> emit,
  ) async {
    await _profilPort.changerMotDePasse(motDePasse: state.motDePasse);
    emit(state.copyWith(motPasseEstChange: true));
  }

  final ProfilPort _profilPort;
}
