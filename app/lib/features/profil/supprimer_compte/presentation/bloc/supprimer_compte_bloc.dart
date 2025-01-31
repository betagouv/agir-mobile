import 'package:app/features/authentification/core/infrastructure/authentification_repository.dart';
import 'package:app/features/profil/core/domain/profil_port.dart';
import 'package:app/features/profil/supprimer_compte/presentation/bloc/supprimer_compte_event.dart';
import 'package:app/features/profil/supprimer_compte/presentation/bloc/supprimer_compte_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupprimerCompteBloc
    extends Bloc<SupprimerCompteEvent, SupprimerCompteState> {
  SupprimerCompteBloc({
    required final AuthentificationRepository authentificationRepository,
    required final ProfilPort profilPort,
  }) : super(const SupprimerCompteState()) {
    on<SupprimerCompteSuppressionDemandee>((final event, final emit) async {
      await profilPort.supprimerLeCompte();
      await authentificationRepository.deconnexionDemandee();
    });
  }
}
