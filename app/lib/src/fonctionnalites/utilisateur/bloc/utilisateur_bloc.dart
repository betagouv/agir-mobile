import 'dart:async';
import 'package:app/src/fonctionnalites/utilisateur/bloc/utilisateur_event.dart';
import 'package:app/src/fonctionnalites/utilisateur/bloc/utilisateur_state.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/ports/utilisateur_repository.dart';
import 'package:app/src/fonctionnalites/utilisateur/domain/utilisateur.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UtilisateurBloc extends Bloc<UtilisateurEvent, UtilisateurState> {
  UtilisateurBloc({
    required final UtilisateurRepository utilisateurRepository,
  })  : _utilisateurRepository = utilisateurRepository,
        super(const UtilisateurState(prenom: '', aLesAides: false)) {
    on<UtilsateurRecuperationDemandee>(_onRecuperationDemandee);
  }

  Future<void> _onRecuperationDemandee(
    final UtilsateurRecuperationDemandee event,
    final Emitter<UtilisateurState> emit,
  ) async {
    final utilisateur = await _utilisateurRepository.recupereUtilisateur();
    emit(
      UtilisateurState(
        prenom: utilisateur.prenom,
        aLesAides: utilisateur.fonctionnalitesDebloquees
            .contains(Fonctionnalites.aides),
      ),
    );
  }

  final UtilisateurRepository _utilisateurRepository;
}
