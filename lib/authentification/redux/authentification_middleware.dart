import 'package:agir/agir_state.dart';
import 'package:agir/authentification/authenticateUser_usecase.dart';
import 'package:agir/authentification/ports/authentification_repository.dart';
import 'package:redux/redux.dart';

import 'authentification_actions.dart';

class AuthentificationMiddlewares {
  final AuthentificationRepository _authentificationRepository;

  AuthentificationMiddlewares._internal(this._authentificationRepository);

  static List<Middleware<AgirState>> createAuthentificationMiddlewares(AuthentificationRepository authentificationRepository) {
    final authentificationMiddlewares = AuthentificationMiddlewares._internal(authentificationRepository);
    return [TypedMiddleware<AgirState,DoAuthentificationAction>(authentificationMiddlewares._onDoAuthentificationAction).call];
  }

  Future<void> _onDoAuthentificationAction(Store<AgirState> store, DoAuthentificationAction action, NextDispatcher next) async {
    next(action);
    final authentificationUsecase = AuthenticateUseCase(_authentificationRepository);
    final utilisateur = await authentificationUsecase.execute(action.userName);
    store.dispatch(HandleAuthentificationResultAction(utilisateur.nom,utilisateur.id));
  }
}



