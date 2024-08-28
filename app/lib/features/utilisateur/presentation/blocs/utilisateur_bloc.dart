import 'dart:async';

import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/features/utilisateur/domain/ports/utilisateur_port.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_event.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

class UtilisateurBloc extends Bloc<UtilisateurEvent, UtilisateurState> {
  UtilisateurBloc({required final UtilisateurPort utilisateurPort})
      : _utilisateurPort = utilisateurPort,
        super(
          const UtilisateurState(
            prenom: null,
            estIntegrationTerminee: true,
            aLesAides: false,
            aLaBibliotheque: false,
            aLesRecommandations: false,
            aLesUnivers: false,
          ),
        ) {
    on<UtilisateurRecuperationDemandee>(_onRecuperationDemandee);
  }

  final UtilisateurPort _utilisateurPort;

  Future<void> _onRecuperationDemandee(
    final UtilisateurRecuperationDemandee event,
    final Emitter<UtilisateurState> emit,
  ) async {
    final result = await _utilisateurPort.recupereUtilisateur();
    if (result.isRight()) {
      final utilisateur = result.getRight().getOrElse(() => throw Exception());
      final fonctionnalitesDebloquees = utilisateur.fonctionnalitesDebloquees;
      emit(
        UtilisateurState(
          prenom: utilisateur.prenom,
          estIntegrationTerminee: utilisateur.estIntegrationTerminee,
          aLesAides: fonctionnalitesDebloquees.contains(Fonctionnalites.aides),
          aLaBibliotheque:
              fonctionnalitesDebloquees.contains(Fonctionnalites.bibliotheque),
          aLesRecommandations: fonctionnalitesDebloquees
              .contains(Fonctionnalites.recommandations),
          aLesUnivers:
              fonctionnalitesDebloquees.contains(Fonctionnalites.univers),
        ),
      );
    }
  }
}
