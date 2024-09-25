import 'package:app/features/authentification/core/domain/authentification_port.dart';
import 'package:app/features/utilisateur/domain/utilisateur.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_event.dart';
import 'package:app/features/utilisateur/presentation/bloc/utilisateur_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UtilisateurBloc extends Bloc<UtilisateurEvent, UtilisateurState> {
  UtilisateurBloc({required final AuthentificationPort authentificationPort})
      : super(
          const UtilisateurState(
            utilisateur: Utilisateur(
              prenom: '',
              estIntegrationTerminee: true,
              aMaVilleCouverte: true,
            ),
          ),
        ) {
    on<UtilisateurRecuperationDemandee>((final event, final emit) async {
      final result = await authentificationPort.recupereUtilisateur();
      result.fold(
        (final l) {},
        (final utilisateur) => emit(UtilisateurState(utilisateur: utilisateur)),
      );
    });
  }
}
