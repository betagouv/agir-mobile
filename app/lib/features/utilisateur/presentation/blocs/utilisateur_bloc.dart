import 'dart:async';

import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/features/utilisateur/domain/ports/utilisateur_port.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_event.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UtilisateurBloc extends Bloc<UtilisateurEvent, UtilisateurState> {
  UtilisateurBloc({required final UtilisateurPort utilisateurPort})
      : _utilisateurPort = utilisateurPort,
        super(const UtilisateurState(prenom: '', aLesAides: false)) {
    on<UtilisateurRecuperationDemandee>(_onRecuperationDemandee);
  }

  Future<void> _onRecuperationDemandee(
    final UtilisateurRecuperationDemandee event,
    final Emitter<UtilisateurState> emit,
  ) async {
    final utilisateur = await _utilisateurPort.recupereUtilisateur();
    emit(
      UtilisateurState(
        prenom: utilisateur.prenom,
        aLesAides: utilisateur.fonctionnalitesDebloquees
            .contains(Fonctionnalites.aides),
      ),
    );
  }

  final UtilisateurPort _utilisateurPort;
}
