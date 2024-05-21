import 'package:agir/agir_state.dart';
import 'package:agir/interactions/fetchInteractions_usecase.dart';
import 'package:agir/interactions/ports/interactions_repository.dart';
import 'package:redux/redux.dart';

import 'interactions_actions.dart';

class InteractionsMiddlewares {
  final InteractionsRepository _interactionsRepository;

  InteractionsMiddlewares(this._interactionsRepository);

  static List<Middleware<AgirState>> createInteractionMiddlewares(InteractionsRepository interactionsRepository) {
    final middlewares = InteractionsMiddlewares(interactionsRepository);
    return [TypedMiddleware<AgirState,LoadInteractionsActions>(middlewares._onLoadInteractionsActions).call];
  }

  Future<void> _onLoadInteractionsActions(Store<AgirState> store, LoadInteractionsActions action, NextDispatcher next) async {
    next(action);
    final interactionsUseCase = FetchInteractionUseCase(_interactionsRepository);
    final interactions = await interactionsUseCase.execute(action.utilisateurId);
    store.dispatch(HandleLoadInteractionsResultActions(interactions));
  }
}



