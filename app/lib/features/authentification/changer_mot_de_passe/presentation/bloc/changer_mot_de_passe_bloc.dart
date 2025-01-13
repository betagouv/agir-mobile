import 'package:app/features/authentification/changer_mot_de_passe/presentation/bloc/changer_mot_de_passe_event.dart';
import 'package:app/features/authentification/changer_mot_de_passe/presentation/bloc/changer_mot_de_passe_state.dart';
import 'package:app/features/profil/core/domain/profil_port.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangerMotDePasseBloc
    extends Bloc<ChangerMotDePasseEvent, ChangerMotDePasseState> {
  ChangerMotDePasseBloc({required final ProfilPort profilPort})
      : super(const ChangerMotDePasseState.empty()) {
    on<ChangerMotDePasseAChange>((final event, final emit) {
      emit(state.copyWith(motDePasse: event.valeur));
    });
    on<ChangerMotDePasseChangementDemande>((final event, final emit) async {
      await profilPort.changerMotDePasse(motDePasse: state.motDePasse);
      emit(state.copyWith(motPasseEstChange: true));
    });
  }
}
