import 'package:app/features/authentification/domain/ports/authentification_port.dart';
import 'package:app/features/utilisateur/domain/entities/utilisateur.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_event.dart';
import 'package:app/features/utilisateur/presentation/blocs/utilisateur_state.dart';
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
