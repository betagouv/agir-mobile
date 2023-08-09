import 'package:agir/agir_state.dart';
import 'package:agir/authentification/redux/utilisateur_state.dart';
import 'package:redux/redux.dart';

import 'authentification_actions.dart';

List<Reducer<AgirState>> createAuthentificationReducers() {
  return [TypedReducer<AgirState,HandleAuthentificationResultAction>(_onHandleAuthentificationResultAction).call];
}

AgirState _onHandleAuthentificationResultAction(AgirState state, HandleAuthentificationResultAction action)  {
  return AgirState(UtilisateurState(action.userId,action.userName), state.interactionsState);
}