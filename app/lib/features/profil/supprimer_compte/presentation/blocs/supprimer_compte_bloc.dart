import 'dart:async';

import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/profil/domain/ports/profil_port.dart';
import 'package:app/features/profil/supprimer_compte/presentation/blocs/supprimer_compte_event.dart';
import 'package:app/features/profil/supprimer_compte/presentation/blocs/supprimer_compte_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupprimerCompteBloc
    extends Bloc<SupprimerCompteEvent, SupprimerCompteState> {
  SupprimerCompteBloc({
    required final AuthentificationPort authentificationPort,
    required final ProfilPort profilPort,
  })  : _authentificationPort = authentificationPort,
        _profilPort = profilPort,
        super(const SupprimerCompteState()) {
    on<SupprimerCompteSuppressionDemandee>(_onSuppressionDemandee);
  }
  final AuthentificationPort _authentificationPort;
  final ProfilPort _profilPort;

  Future<void> _onSuppressionDemandee(
    final SupprimerCompteSuppressionDemandee event,
    final Emitter<SupprimerCompteState> emit,
  ) async {
    await _profilPort.supprimerLeCompte();
    await _authentificationPort.deconnexionDemandee();
  }
}
