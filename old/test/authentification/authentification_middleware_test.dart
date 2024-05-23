import 'package:agir/agir_state.dart';
import 'package:agir/authentification/authenticateUser_usecase.dart';
import 'package:agir/authentification/ports/authentification_repository.dart';
import 'package:agir/authentification/redux/authentification_actions.dart';
import 'package:agir/authentification/redux/authentification_middleware.dart';
import 'package:agir/authentification/redux/authentification_reducer.dart';
import 'package:agir/authentification/redux/utilisateur_state.dart';
import 'package:agir/interactions/redux/interactions_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';

class AuthentificationRepositoryForTest implements AuthentificationRepository {
  @override
  Future<Utilisateur> doAuthentification(String userName) {
    return Future.value(Utilisateur("Dorian", "1"));
  }
}

void main() {
  group("Tests du middleware", () {
    test(
        "DoAuthentificationAction doit sauvegarder Iel dans le store en cas de succès",
        () async {
      // GIVEN
      final store = Store<AgirState>(
        combineReducers<AgirState>([...createAuthentificationReducers()]),
        middleware: [
          ...AuthentificationMiddlewares.createAuthentificationMiddlewares(
              AuthentificationRepositoryForTest()),
        ],
        initialState:
            AgirState(const UtilisateurState("", ""), InteractionsState([])),
      );
      // WHEN
      await store.dispatch(DoAuthentificationAction("Dorian"));
      // THEN
      expect(
          store.state.utilisateurState, const UtilisateurState("1", "Dorian"));
    });
  });
}
